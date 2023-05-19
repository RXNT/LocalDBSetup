SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Kalimuthu S    
-- Create DATE: 24-November-2020   
-- Description: Procedure to get the measures data for secure messaging    
-- =============================================    
CREATE PROCEDURE [dbo].[StageIV_Measures_GetElectronicSummaryOfCareRecords]    
	@dr_id INT,
	@dg_id INT =  NULL, 
	@reporting_start_DATE DATE, 
	@reporting_end_DATE DATE, 
	@measureCode VARCHAR(3)   
AS    
BEGIN    
SET NOCOUNT ON;    
	DECLARE @MeasureStage AS VARCHAR(10);    
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
		WHERE 1=1 
		AND ((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
		AND ref.pa_ext_ref = 1 AND
		CAST(ref.pa_ref_date AS DATE) BETWEEN @reporting_start_DATE AND @reporting_end_DATE    
		AND ref.pa_ref_name_details  IS NOT  NULL
	),
	NUMERATOR_PATIENTS AS
	( 	
		SELECT pd.pat_id PatientId
		FROM patient_documents pd WITH(NOLOCK)
		INNER JOIN DENOMINATOR_PATIENTS denom WITH(NOLOCK)  ON denom.PatientId=pd.pat_id
		INNER JOIN doctors doc WITH(NOLOCK)  ON doc.dr_id=pd.src_dr_id
		WHERE 1=1  
		AND ((@dg_id IS  NULL AND pd.src_dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id)) 
		AND pd.cat_id=6  -- Document CCD Type ID
		AND pd.upload_date BETWEEN @reporting_start_DATE AND @reporting_end_DATE
	)  
	
	SELECT  
		VMD.dr_id, 
		MUM.MeasureCode, 
		(SELECT COUNT(DISTINCT PatientId) FROM NUMERATOR_PATIENTS) AS Numerator, 
		(SELECT COUNT(DISTINCT PatientId) FROM DENOMINATOR_PATIENTS) AS Denominator,    
		MUM.MeasureName, 
		MUM.DisplayOrder, 
		MUM.MeasureDescription, 
		MUM.PassingCriteria, 
		MUm.MeasureGroup, 
		MUM.MeasureStage, 
		NULL AS MeasureResult,
		MUM.MeasureGroupName,
		MUM.Id 
	FROM	MEASURES_DATA    VMD WITH(NOLOCK)
	INNER JOIN dbo.MU4Measures    MUM WITH(NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode    
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
