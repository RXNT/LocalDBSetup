SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  RxNT   
-- Create date: 09/13/2017    
-- Description: Procedure to get the measures data for View_Download_Transmit_Patient    
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_Measure_ReceiveAndIncorporate] 
	@dr_id INT,
	@dg_id INT = null,
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@measureCode VARCHAR(3)    
AS    
BEGIN    
	-- SET NOCOUNT ON added to prevent extra result sets from    
	-- interfering with SELECT statements.    
	SET NOCOUNT ON;    
		
	DECLARE @MeasureStage AS VARCHAR(10)    
	SET @MeasureStage = 'MIPS2017';    
	
	WITH MEASURES_DATA AS
	(		
		SELECT  @measureCode AS MeasureCode, 
				@MeasureStage AS MeasureStage, 
				@dr_id AS dr_id    
	),  
	PETIENT_ENCOUNTERS AS    
	(  
		SELECT enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob      
		FROM dbo.enchanced_encounter enc WITH(NOLOCK)      
		INNER JOIN dbo.patients pat WITH(NOLOCK) ON pat.pa_id=enc.patient_id     
		INNER JOIN referral_main   rm   with(nolock) on rm.pa_id   = pat.pa_id 
		WHERE 1=1
		AND   enc.dr_id  = @dr_id    
		AND   enc.enc_date between @reporting_start_date and @reporting_end_date    
		AND   enc.type_of_visit = 'OFICE'    
		AND	  enc.issigned = 1
		and   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
		GROUP BY  enc.patient_id, enc.dr_id ,pat.pa_dob  
	),
	DENOMINATOR_PATIENTS AS    
	(   
		SELECT pen.patient_id as DenomPatient   
		FROM  PETIENT_ENCOUNTERS   pen  with(nolock)    
		INNER JOIN dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id  
		INNER JOIN referral_main   rm   with(nolock) on rm.pa_id   = pat.pa_id  
		where  1=1  
		group by pen.patient_id    
	),
	NUMERATOR_PATIENTS AS
	( 	
		SELECT DISTINCT DP.DenomPatient as NumPatient 
		FROM  dbo.direct_email_sent_messages de with(nolock) 
		INNER JOIN DENOMINATOR_PATIENTS DP ON DP.DenomPatient=de.pat_id
		WHERE de.attachment_type = 'CCD' and	  de.send_success = 1 
		AND   de.sent_date between @reporting_start_date and @reporting_end_date 
	)  
	
	SELECT  VMD.dr_id, 
			MUM.MeasureCode, 
			(SELECT COUNT(DISTINCT NumPatient) FROM NUMERATOR_PATIENTS) AS Numerator, 
			(SELECT COUNT(DISTINCT DenomPatient) FROM DENOMINATOR_PATIENTS) AS Denominator,    
			MUM.MeasureName, 
			MUM.DisplayOrder, 
			MUM.MeasureDescription, 
			MUM.PassingCriteria, 
			MUm.MeasureGroup, 
			MUM.MeasureStage, 
			null AS MeasureResult,
			MUM.MeasureGroupName,
			MUM.Id,
			MUM.MeasureClass,  
			MUM.Performace_points_per_10_percent,
			MUM.MeasureCalculation   
	FROM	measures_data    VMD  WITH (NOLOCK)
			INNER JOIN dbo.MIPSMeasures    MUM  WITH (NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode    
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
