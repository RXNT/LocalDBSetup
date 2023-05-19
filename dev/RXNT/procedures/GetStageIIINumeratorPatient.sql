SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 14th March 2018
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetStageIIINumeratorPatient] 
	@dr_id INT, 
	@dtstart DATE, 
	@dtend DATE, 
	@MeasureCode VARCHAR(3),
	@dg_id INT = NULL  
AS
BEGIN

	IF (@dg_id = 0)
		BEGIN
			set @dg_id = null
		END
	IF @MeasureCode<>''
	BEGIN
		IF @MeasureCode='DFQ'
			BEGIN 
				SELECT
					pat.pa_id as Patient,
					pat.pa_first as FirstName,
					pat.pa_last as LastName,
					pat.pa_dob as DateOfBirth,
					pat.pa_sex as sex,
					pat.pa_address1 as Address1,
					pat.pa_city as City,
					pat.pa_state as [State],
					pat.pa_zip as ZipCode,
					pat.pa_ssn as chart  
				FROM prescriptions p WITH(NOLOCK) 
				INNER JOIN prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
				INNER JOIN RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
				LEFT JOIN patients pat WITH(NOLOCK)  ON pat.pa_id=p.pa_id
				WHERE ((@dg_id IS NULL and p.dr_id = @dr_id) OR (@dg_id IS NOT NULL AND p.dg_id=@dg_id)) 
				AND p.pres_delivery_method > 2
				AND p.pres_void = 0 AND
				p.pres_approved_date BETWEEN @dtstart and @dtend
			END
		
		IF @MeasureCode='PTE'
		BEGIN
			SELECT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart  
			FROM prescriptions p WITH(NOLOCK)  
			INNER JOIN prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
			INNER JOIN RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
			LEFT JOIN patients pat WITH(NOLOCK)  ON pat.pa_id=p.pa_id
			WHERE ((@dg_id IS NULL and p.dr_id = @dr_id) OR (@dg_id IS NOT NULL AND p.dg_id=@dg_id)) 
			AND  p.pres_delivery_method > 2
			AND p.pres_void = 0
			AND RV.MED_REF_DEA_CD NOT IN (2,3,4,5)  
			AND p.pres_approved_date between @dtstart and @dtend
			
		END
		
		IF @MeasureCode='CPM'
		BEGIN 
			select DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart  
			from prescriptions p WITH(NOLOCK)  
			LEFT JOIN patients pat WITH(NOLOCK) ON pat.pa_id=p.pa_id
			where 
			((@dg_id IS NULL and p.dr_id = @dr_id) OR
			(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			p.pres_delivery_method > 2 
			and p.pres_approved_date between @dtstart and @dtend
		END
		
		IF @MeasureCode='CPL'
		BEGIN
			select DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart  
			from lab_main p WITH(NOLOCK)  
			LEFT JOIN patients pat WITH(NOLOCK) ON pat.pa_id=p.pat_id
			where 
			((@dg_id IS NULL and p.dr_id = @dr_id) OR
			(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			p.type='Lab'
			and p.message_date between  @dtstart and @dtend
		END
		
		IF @MeasureCode='CPR'
		BEGIN
			select DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart 
			from lab_main p WITH(NOLOCK)  
			LEFT JOIN patients pat WITH(NOLOCK) ON pat.pa_id=p.pat_id
			where 
			((@dg_id IS NULL and p.dr_id = @dr_id) OR
			(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			p.type='Image'
			and p.message_date between  @dtstart and @dtend
		END
		
		IF @MeasureCode='DCP'
		BEGIN 
			SELECT  DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart 
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			INNER JOIN dbo.patient_reg_db  prd ON enc.patient_id=prd.pa_id
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
			WHERE 1=1 
			AND	((@dg_id IS NULL and enc.dr_id = @dr_id) OR
			(@dg_id IS NOT NULL AND pat.dg_id=@dg_id))
			AND enc.enc_date BETWEEN @dtstart and @dtend   
			AND enc.type_of_visit = 'OFICE'    
			AND	enc.issigned = 1 
		END
		
		IF @MeasureCode='PAE'
		BEGIN
			WITH DENOMINATOR_PATIENT AS    
			(    
				SELECT DISTINCT enc.patient_id AS PatientId 
				FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
				INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id 
				WHERE  1=1  
				AND	((@dg_id IS NULL and enc.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND pat.dg_id=@dg_id))  
				AND enc.enc_date BETWEEN @dtstart and @dtend   
				AND	enc.issigned = 1  
			)
			
			SELECT DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart 
			FROM  dbo.MUMeasureCounts mc WITH(NOLOCK)     
			INNER JOIN DENOMINATOR_PATIENT DP  WITH(NOLOCK)  ON DP.PatientId = mc.pa_id 
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = mc.pa_id    
			WHERE  1=1  
			AND mc.MeasureCode = @measureCode 
			AND mc.IsNumerator = 1   
			AND mc.DateAdded BETWEEN @dtstart and @dtend  
		END
		
		IF @MeasureCode='VDT'
		BEGIN
			WITH DENOMINATOR_PATIENTS AS    
			(    
				SELECT enc.patient_id AS PatientId  
				FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
				INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
				WHERE 1=1 
				AND ((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
				AND enc.enc_date BETWEEN @dtstart AND @dtend    
				AND enc.type_of_visit = 'OFICE'    
				AND	enc.issigned = 1  
				GROUP BY enc.patient_id
			)
			 
			SELECT  
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart 
			FROM DENOMINATOR_PATIENTS  DP  WITH(NOLOCK)      
			INNER JOIN dbo.patient_login pl WITH(NOLOCK) ON pl.pa_id = DP.PatientId   
			INNER JOIN dbo.patients   pat  WITH(NOLOCK) ON pat.pa_id  = DP.PatientId  
		END
		
		IF @MeasureCode='SEM'
		BEGIN 
			WITH DENOMINATOR_PATIENTS AS    
			(    
				SELECT DISTINCT enc.patient_id AS PatientId 
				FROM enchanced_encounter enc WITH(NOLOCK)
				INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
				WHERE 
				((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
				AND enc.enc_date BETWEEN @dtstart AND @dtend
				AND enc.issigned=1  
			)
			
			SELECT DISTINCT
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart 
			FROM  dbo.MUMeasureCounts MDRP    WITH(NOLOCK)
			INNER JOIN  DENOMINATOR_PATIENTS  DP  WITH(NOLOCK) ON  MDRP.pa_id = DP.PatientId 
			INNER JOIN dbo.patients   pat  WITH(NOLOCK) ON pat.pa_id  = DP.PatientId  
			INNER JOIN doctors doc WITH(NOLOCK) ON MDRP.dr_id=doc.dr_id
			WHERE 
			((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id))
			AND MDRP.MeasureCode = @meASureCode 
			AND MDRP.IsNumerator = 1 
			AND MDRP.DateAdded  BETWEEN @dtstart AND @dtend  
		END
		
		IF @MeasureCode='PPD'
		BEGIN
			WITH DENOMINATOR_PATIENTS AS    
			( 
				SELECT DISTINCT enc.patient_id AS DenomPatient 
				FROM enchanced_encounter enc WITH(NOLOCK)
				INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
				WHERE 
				((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
				AND enc.enc_date BETWEEN @dtstart AND @dtend
				AND enc.issigned=1  
			)
			SELECT  DISTINCT
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart 
			FROM patient_documents ppd WITH(NOLOCK)
			INNER JOIN DENOMINATOR_PATIENTS den WITH(NOLOCK) ON ppd.pat_id=den.DenomPatient
			INNER JOIN patient_documents_category doc_cat ON ppd.cat_id=doc_cat.cat_id
			INNER JOIN doctors doc WITH(NOLOCK) ON ppd.src_dr_id=doc.dr_id
			INNER JOIN patients pat WITH(NOLOCK) ON den.DenomPatient=pat.pa_id
			WHERE 
			((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
			AND ppd.upload_date BETWEEN @dtstart AND @dtend 
			AND doc_cat.title='Patient Portal Documents'
		END
		
		IF @MeasureCode='HIE'
		BEGIN  
			WITH PATIENT_REFERRALS AS    
			(    
				SELECT  rm.pa_id AS patient_id, rm.main_dr_id AS dr_id, rm.ref_id   
				FROM  referral_main  rm  WITH(NOLOCK)    
				INNER JOIN patients pat WITH(NOLOCK) ON   rm.pa_id=pat.pa_id
				WHERE 
				((@dg_id IS  NULL AND rm.main_dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
				AND rm.ref_start_date BETWEEN @dtstart AND @dtend  
				GROUP BY rm.pa_id, rm.main_dr_id , rm.ref_id  
			),
			NUMERATOR_PATIENTS AS    
			( 
				SELECT pat.patient_id  AS PatientId, pat.dr_id, pat.ref_id--, MUC.Id
				FROM  patient_referrals    pat WITH(NOLOCK) 
				WHERE  1=1
				AND EXISTS (
					SELECT TOP 1 * FROM  dbo.direct_email_sent_messages de WITH(NOLOCK) 
					WHERE de.attachment_type = 'CCD' AND pat.ref_id=de.ref_id
					AND	  de.send_success = 1 
					AND   de.sent_date BETWEEN @dtstart AND @dtend   
					AND de.pat_id = pat.patient_id
				)
				AND EXISTS(
					SELECT TOP 1 * FROM  dbo.MUMeasureCounts MUC  WITH(NOLOCK) 
					WHERE MUC.pa_id = pat.patient_id 
					AND pat.dr_id=MUC.dr_id
					AND   MUC.IsNumerator = 1 
					AND   MUC.dr_id  = pat.dr_id
					AND   MUC.MeasureCode = 'SC2'
					AND	  MUC.DateAdded  BETWEEN @dtstart AND @dtend
					AND ((@dg_id IS  NULL AND MUC.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND MUC.dg_id=@dg_id)) 
				)
				GROUP BY pat.patient_id , pat.dr_id, pat.ref_id
			) 
			
			SELECT 
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart 
			FROM patients pat WITH(NOLOCK) 
			INNER JOIN NUMERATOR_PATIENTS NP WITH(NOLOCK)  ON NP.PatientId=pat.pa_id
		END
		
		IF @MeasureCode='ESR'
		BEGIN
			WITH DENOMINATOR_PATIENTS AS    
			(  
				SELECT DISTINCT pat.pa_id PatientId
				FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
				INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
				WHERE 1=1 
				AND ((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
				AND ref.pa_ext_ref = 1 AND
				CAST(ref.pa_ref_date AS DATE) BETWEEN @dtstart AND @dtend   
				AND ref.pa_ref_name_details  IS NOT  NULL
			)
			
			SELECT DISTINCT
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart
			FROM patient_documents pd WITH(NOLOCK)
			INNER JOIN DENOMINATOR_PATIENTS denom WITH(NOLOCK)  ON denom.PatientId=pd.pat_id
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = denom.PatientId 
			INNER JOIN doctors doc WITH(NOLOCK)  ON doc.dr_id=pd.src_dr_id 
			WHERE 1=1  
			AND ((@dg_id IS  NULL AND pd.src_dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id)) 
			AND pd.cat_id=6 
			AND pd.upload_date BETWEEN @dtstart AND @dtend 
		END
		
		IF @MeasureCode='MDR'
		BEGIN
			WITH DENOMINATOR_PATIENTS AS      
			(
				SELECT DISTINCT pat.pa_id PatientId
				FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
				INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
				WHERE 1=1 AND
				((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
				AND ref.pa_ext_ref = 1 
				AND CAST(ref.pa_ref_date AS DATE) BETWEEN @dtstart AND @dtend    
				AND ref.pa_ref_name_details  IS NOT  NULL
			)
			SELECT  DISTINCT 
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart   
			FROM  dbo.MUMeasureCounts   MUC  WITH(NOLOCK)    
			INNER JOIN DENOMINATOR_PATIENTS DP WITH(NOLOCK)   ON  DP.PatientId = MUC.pa_id  
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = DP.PatientId 
			WHERE  1=1 
			AND MUC.MeasureCode    =  @MeasureCode  
			AND MUC.IsNumerator = 1
		END

		IF @MeasureCode='CLR'
		BEGIN

		WITH DENOMINATOR_PATIENTS AS      
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
			BETWEEN @dtstart AND @dtend
			AND ref.pa_ref_name_details  IS NOT  NULL
		)   
			SELECT pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart     
			FROM  DENOMINATOR_PATIENTS DP  WITH(NOLOCK)
			INNER JOIN dbo.patients pat  WITH(NOLOCK) ON pat.pa_id  = DP.pa_id  
			WHERE  1=1 AND
			DP.is_allergy_reconciled = 1 AND
			DP.is_medication_reconciled = 1 AND
			DP.is_problem_reconciled = 1	
		END
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
