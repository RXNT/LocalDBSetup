SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Niyaz Hussain  
-- Create DATE: 0`-Feb-2018
-- Description: Procedure to get the measures data for secure messaging    
-- =============================================    
CREATE PROCEDURE [dbo].[StageIII_Measures_Get_PartnerPatientDocument]    
	@dr_id INT, 
	@dg_id INT=NULL,  
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@measureCode VARCHAR(3) --= 'SEM'    
AS    
BEGIN        
	SET NOCOUNT ON;    
	DECLARE @MeasureStage AS VARCHAR(10);    
	SET @MeasureStage = 'MU2015'; 
	SET @MeasureCode = 'PPD'; 
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
		SELECT DISTINCT enc.patient_id AS DenomPatient 
		FROM enchanced_encounter enc WITH(NOLOCK)
		INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
		WHERE 
		((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
		AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
		AND enc.issigned=1  
	),    
	NUMERATOR_PATIENTS AS    
	(
		SELECT DISTINCT ppd.pat_id  AS NumPatient
		FROM patient_documents ppd WITH(NOLOCK)
		INNER JOIN DENOMINATOR_PATIENTS den WITH(NOLOCK) ON ppd.pat_id=den.DenomPatient
		INNER JOIN patient_documents_category doc_cat ON ppd.cat_id=doc_cat.cat_id
		INNER JOIN doctors doc WITH(NOLOCK) ON ppd.src_dr_id=doc.dr_id
		INNER JOIN patients pat WITH(NOLOCK) ON den.DenomPatient=pat.pa_id
		WHERE 
		((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
		AND ppd.upload_date BETWEEN @reporting_start_date AND @reporting_end_date 
		AND doc_cat.title='Patient Portal Documents'
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
		MUM.MeasureGroupName,MUM.Id
	FROM  measures_data    VMD  WITH(NOLOCK)    
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
