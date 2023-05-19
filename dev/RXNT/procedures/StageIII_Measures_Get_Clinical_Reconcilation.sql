SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================   
-- Create DATE: 10/28/2019
-- Description: Procedure to get the measures data for recon  
-- =============================================      
CREATE PROCEDURE [dbo].[StageIII_Measures_Get_Clinical_Reconcilation]    
	@dr_id INT, 
	@dg_id INT=NULL,  
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
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
		SELECT reconciliation_id, is_allergy_reconciled, is_medication_reconciled, is_problem_reconciled,
		 rec.pa_id, rec.dr_id, rec.dg_id
		from patient_external_ccd_reconciliation_info rec WITH(NOLOCK)
		inner join  dbo.patient_extended_details ref WITH(NOLOCK) 
		ON ref.pa_id = rec.pa_id
		WHERE 1=1
		AND ((@dg_id IS  NULL AND rec.dr_id = @dr_id) OR (@dg_id IS NOT  NULL
		AND rec.dg_id=@dg_id)) 
		AND ref.pa_ext_ref = 1 AND CAST(rec.date_added AS DATE) 
		BETWEEN @reporting_start_date AND @reporting_end_date
		AND ref.pa_ref_name_details  IS NOT  NULL

	),
	NUMERATOR_PATIENTS AS    
	(   
		SELECT reconciliation_id  
		FROM  DENOMINATOR_PATIENTS DP  WITH(NOLOCK)    
		WHERE  1=1 AND
		DP.is_allergy_reconciled = 1 AND
		DP.is_medication_reconciled = 1 AND
		DP.is_problem_reconciled = 1
	)
  
     
	SELECT  
		VMD.dr_id,
		MUM.MeasureCode, 
		(SELECT COUNT(reconciliation_id) AS Numerator FROM  DENOMINATOR_PATIENTS WITH(NOLOCK) ) AS Denominator, 
		(SELECT COUNT(reconciliation_id) AS Denominator FROM  NUMERATOR_PATIENTS WITH(NOLOCK) ) AS Numerator,  
		MUM.MeasureName, 
		MUM.DisplayOrder, 
		MUM.MeasureDescription, 
		MUM.PassingCriteria, 
		MUm.MeasureGroup, 
		MUM.MeasureStage, 
		NULL AS MeasureResult,
		MUM.MeasureGroupName,
		MUM.Id
	FROM  MEASURES_DATA VMD WITH(NOLOCK)    
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
