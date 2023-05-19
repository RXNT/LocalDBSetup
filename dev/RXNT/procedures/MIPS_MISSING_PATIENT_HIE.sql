SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 --=============================================        
 --Author:  RxNT        
 --Create date: 13/09/2017        
 --Description: Procedure to get the measures non 
 --				qualifying data for View Download 
 --				Transmit Doctor     
 --=============================================        
CREATE PROCEDURE [dbo].[MIPS_MISSING_PATIENT_HIE]        
 @dr_id int, 
 @reporting_start_date date,
 @reporting_end_date date ,
 @measureCode varchar(10)       
AS        
BEGIN
	SET NOCOUNT ON;        
	
	WITH MEASURES_DATA AS      
	(      
		SELECT 
			@MeasureCode AS MeasureCode, 
			@dr_id AS dr_id      
	),      
	PATIENT_ENCOUNTERS AS      
	(      
		SELECT  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob  
		FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
		INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id   
		INNER JOIN referral_main   rm   WITH(NOLOCK) ON rm.pa_id   = pat.pa_id 
		WHERE  1=1    
		AND enc.dr_id  = @dr_id    
		AND enc.enc_date between @reporting_start_date AND @reporting_end_date    
		AND enc.type_of_visit = 'OFICE'    
		AND	enc.issigned = 1
		AND rm.ref_start_date between @reporting_start_date AND @reporting_end_date  
		GROUP BY enc.patient_id, enc.dr_id, pat.pa_dob  
	),   
	DENOMINATOR_PATIENT AS      
	( 
		SELECT  DISTINCT pa_id  As DenomPatient   
		FROM  dbo.MUMeasureCounts   MUC  with(nolock)      
		INNER JOIN PATIENT_ENCOUNTERS   pe  ON  pe.patient_id = MUC.pa_id      
		WHERE  1=1         
		AND MUC.MeasureCode    =  @MeasureCode   
		AND MUC.IsDenominator = 1    
		AND MUC.DateAdded      BETWEEN  @reporting_start_date and @reporting_end_date 
	), 
    NUMERATOR_PATIENT AS      
   (      
		SELECT  pe.patient_id  AS NumPatient   
		FROM  dbo.MUMeasureCounts   MUC  with(nolock)      
		INNER JOIN PATIENT_ENCOUNTERS   pe  ON  pe.patient_id = MUC.pa_id   
		AND MUC.DateAdded      BETWEEN     @reporting_start_date AND @reporting_end_date 
		INNER JOIN   DENOMINATOR_PATIENT de ON de.DenomPatient = MUC.pa_id   
		WHERE  1=1          
		AND   MUC.MeasureCode    =  @MeasureCode      
   )
   
	SELECT pa_id AS Patient,pa_first AS FirstName,pa_last AS LastName,pat.pa_dob AS DateOfBirth,pa_sex AS sex,
	pa_address1 AS Address1,pa_city AS City,pa_state AS [State],pa_zip AS ZipCode,pa_ssn AS chart
	FROM  dbo.Patients    PAT  WITH(NOLOCK)      
	INNER JOIN DENOMINATOR_PATIENT   DEN  WITH(NOLOCK) on DEN.DenomPatient   = PAT.pa_id    
	LEFT JOIN NUMERATOR_PATIENT    NUM  WITH(NOLOCK) on NUM.NumPatient = NUM.NumPatient
	WHERE NUM.NumPatient IS NULL 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
