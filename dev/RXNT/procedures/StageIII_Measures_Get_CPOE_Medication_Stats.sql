SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[StageIII_Measures_Get_CPOE_Medication_Stats]      
	@dr_id INT, 
	@dg_id INT=NULL,  
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@MeasureCode VARCHAR(3)      
AS   
BEGIN   
	SET NOCOUNT ON;    
	DECLARE @MeasureStage AS VARCHAR(10)
	SET @MeasureStage = 'MU2015';    
	SET @MeasureCode = 'CPM';    
    
	WITH MEASURES_DATA AS    
	(    
		SELECT  
			@MeasureCode AS MeasureCode, 
			@MeasureStage AS MeasureStage, 
			@dr_id AS dr_id, 
			@dg_id  AS dg_id
	),    
	DENOMINATOR_PATIENTS AS    
	( 
		SELECT p.pa_id AS DenomPatient
		FROM prescriptions p  WITH(NOLOCK) 
		WHERE 
		((@dg_id IS  NULL AND p.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND p.dg_id=@dg_id)) 
		AND p.pres_delivery_method > 2 
		AND p.pres_approved_date BETWEEN @reporting_start_date AND @reporting_end_date

	),    
	NUMERATOR_PATIENTS AS    
	(
		SELECT p.pa_id AS NumPatient
		FROM prescriptions p WITH(NOLOCK)  
		WHERE 
		((@dg_id IS  NULL AND p.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND p.dg_id=@dg_id)) 
		AND p.pres_delivery_method > 2 
		AND p.pres_approved_date BETWEEN @reporting_start_date AND @reporting_end_date

	)    
    
	SELECT  
		VMD.dr_id, 
		MUM.MeasureCode, 
		(SELECT COUNT(DenomPatient) FROM DENOMINATOR_PATIENTS WITH(NOLOCK) ) AS Denominator, 
		(SELECT COUNT(NumPatient) FROM NUMERATOR_PATIENTS WITH(NOLOCK) ) AS Numerator, 
		MUM.MeasureName, 
		MUM.DisplayOrder, 
		MUM.MeasureDescription, 
		MUM.PassingCriteria, 
		MUm.MeasureGroup, 
		MUM.MeasureStage,  
		NULL AS MeasureResult,
		MUM.MeasureGroupName,
		MUM.Id
	FROM  MEASURES_DATA    VMD  WITH(NOLOCK)    
	INNER JOIN dbo.MU3Measures    MUM  WITH(NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode    
	AND MUM.MeasureCode  = @MeasureCode    
	AND MUM.IsActive  = 1    
	AND MUM.MeasureStage = @MeasureStage  
     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
