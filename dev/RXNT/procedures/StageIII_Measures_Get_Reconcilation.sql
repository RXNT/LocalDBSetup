SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================   
-- Author:  Niyaz Hussain  
-- Create DATE: 13-March-2018
-- Description: Procedure to get the measures data for recon  
-- =============================================      
CREATE PROCEDURE [dbo].[StageIII_Measures_Get_Reconcilation]    
	@dr_id INT, 
	@dg_id INT=NULL,  
	@reporting_start_DATE DATE, 
	@reporting_end_DATE DATE, 
	@measureCode VARCHAR(3)    
AS    
BEGIN      
	SET NOCOUNT ON;    
	DECLARE @MeasureStage AS VARCHAR(10)    
	SET @MeasureStage = 'MU2015';    

	
	WITH MEASURES_DATA AS    
	(    
		SELECT  @measureCode AS MeasureCode, 
				@MeasureStage AS MeasureStage, 
				@dr_id AS dr_id    
	), 
	DENOMINATOR_PATIENTS AS      
	(
		SELECT DISTINCT pat.pa_id PatientId
		FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
		INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
		WHERE 1=1 AND
		((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
		AND ref.pa_ext_ref = 1 
		AND CAST(ref.pa_ref_date AS DATE) BETWEEN @reporting_start_DATE AND @reporting_end_DATE    
		AND ref.pa_ref_name_details  IS NOT  NULL
	),
	NUMERATOR_PATIENTS AS    
	(   
		SELECT  DISTINCT MUC.pa_id PatientId    
		FROM  dbo.MUMeasureCounts   MUC  WITH(NOLOCK)    
		INNER JOIN DENOMINATOR_PATIENTS DP WITH(NOLOCK) ON  DP.PatientId = MUC.pa_id  
		WHERE  1=1 
		AND MUC.MeasureCode    =  @MeasureCode  
		AND MUC.IsNumerator = 1
	)
  
     
	SELECT  
		VMD.dr_id,
		MUM.MeasureCode, 
		(SELECT COUNT(PatientId) AS Numerator FROM  DENOMINATOR_PATIENTS WITH(NOLOCK) ) AS Denominator, 
		(SELECT COUNT(PatientId) AS Denominator FROM  NUMERATOR_PATIENTS WITH(NOLOCK) ) AS Numerator,  
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
	AND MUM.MeasureCode  = @measureCode    
	AND MUM.IsActive  = 1    
	AND MUM.MeasureStage = @MeasureStage     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
