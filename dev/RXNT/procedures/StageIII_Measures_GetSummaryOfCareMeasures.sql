SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    MU3Measures
-- Author:  Niyaz Hussain  
-- Create DATE: 13-March-2018
-- Description: Procedure to get the measures data for Health InformatiON Exchange    
-- =============================================    
CREATE PROCEDURE [dbo].[StageIII_Measures_GetSummaryOfCareMeasures] -- [ACI_Measure_HIE]  100974,NULL,'1/1/2017','12/31/2017','HIE'
	@dr_id INT, 
	@dg_id INT =  NULL, 
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@measureCode VARCHAR(3)   
AS    
BEGIN    
	SET NOCOUNT ON; 
	DECLARE @dc_id AS INT;
	SELECT @dc_id = dg.dc_id from doctors dr WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK)ON dg.dg_id = dr.dg_id 
	WHERE dr.dr_id=@dr_id;

	IF ISNULL (@dc_id,0 )<= 0 
	BEGIN 
		SELECT @dc_id = dc_id FROM doc_groups WHERE dg_id=@dg_id
	END

	DECLARE @MeasureStage AS VARCHAR(10);    
	SET @MeasureStage = 'MU2015'; 


	select @dg_id=dg_id from doctors Where @dg_id IS NULL AND dr_id=@dr_id;
	
	WITH MEASURES_DATA AS    
	(    
		SELECT  @measureCode AS MeasureCode, 'MIPS2017' AS MeasureStage, @dr_id AS dr_id, @dg_id  AS dg_id    
	),    
	PATIENT_REFERRALS AS    
	(    
		SELECT  rm.pa_id AS patient_id, rm.main_dr_id AS dr_id, rm.ref_id   
		FROM  referral_main  rm  WITH(NOLOCK)    
		INNER JOIN patients pat WITH(NOLOCK) ON   rm.pa_id=pat.pa_id
		WHERE 
		((@dg_id IS  NULL AND rm.main_dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
		AND rm.ref_start_date BETWEEN @reporting_start_date AND @reporting_end_date  
		GROUP BY rm.pa_id, rm.main_dr_id , rm.ref_id  
	), 
	DENOMINATOR_PATIENTS AS    
	(    
		SELECT  DISTINCT pen.patient_id  AS PatientId,     
		pen.dr_id  , pen.ref_id    
		FROM  PATIENT_REFERRALS pen  WITH(NOLOCK)     
		WHERE  1=1  
		GROUP BY pen.dr_id, pen.patient_id , pen.ref_id  
	),
	NUMERATOR_PATIENTS AS    
	( 
		SELECT DISTINCT  pat.patient_id  AS PatientId, pat.dr_id, pat.ref_id--, MUC.Id
		FROM  patient_referrals    pat WITH(NOLOCK) 
		WHERE  1=1
		AND EXISTS (
			SELECT TOP 1 * FROM  dbo.direct_email_sent_messages de WITH(NOLOCK) 
			WHERE de.attachment_type = 'CCD' AND pat.ref_id=de.ref_id
			AND	  de.send_success = 1 
			AND   de.sent_date BETWEEN @reporting_start_date AND @reporting_end_date   
			AND de.pat_id = pat.patient_id
		)
		AND EXISTS(
			SELECT TOP 1 * FROM  dbo.MUMeasureCounts MUC WITH(NOLOCK)  
			WHERE MUC.pa_id = pat.patient_id
			AND MUC.dc_id=@dc_id
			--AND pat.dr_id=MUC.dr_id
			AND   MUC.IsNumerator = 1 
			--AND   MUC.dr_id  = pat.dr_id
			AND   MUC.MeasureCode = 'SC2'
			AND	  MUC.DateAdded  BETWEEN @reporting_start_date AND @reporting_end_date
			--AND ((@dg_id IS  NULL AND MUC.dr_id = @dr_id) OR 
			AND MUC.dg_id=@dg_id
		)
		GROUP BY pat.patient_id , pat.dr_id, pat.ref_id
	) 
 
	SELECT  
		VMD.dr_id, 
		MUM.MeasureCode,
		(SELECT COUNT(PatientId) FROM NUMERATOR_PATIENTS WITH(NOLOCK) ) AS Numerator, 
		(SELECT COUNT(PatientId) FROM DENOMINATOR_PATIENTS WITH(NOLOCK) ) AS Denominator,
		MUM.MeasureName, 
		MUM.DisplayOrder, 
		MUM.MeasureDescription, 
		MUM.PassingCriteria, 
		MUM.MeasureGroup, 
		MUM.MeasureStage,  
		NULL AS MeasureResult,
		MUM.MeasureGroupName,MUM.Id
	FROM  measures_data    VMD  WITH(NOLOCK)    
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
