SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[StageIV_Measures_Get_CPOE_Radiology]      
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
	SET @MeasureCode = 'CPR';    
    
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
		SELECT p.pat_id AS DenomPatient
		FROM lab_main p WITH(NOLOCK)  
		WHERE 
		((@dg_id IS  NULL AND p.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND p.dg_id=@dg_id)) 
		AND p.type='Image'
		AND p.message_date BETWEEN @reporting_start_date AND @reporting_end_date
	),    
	NUMERATOR_PATIENTS AS    
	(
		SELECT p.pat_id AS NumPatient
		FROM lab_main p  WITH(NOLOCK) 
		WHERE 
		((@dg_id IS  NULL AND p.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND p.dg_id=@dg_id)) 
		AND p.type='Image'
		AND p.message_date BETWEEN @reporting_start_date AND @reporting_end_date
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
	INNER JOIN dbo.MU4Measures   MUM  WITH(NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode    
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
