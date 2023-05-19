SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kalimuthu S 
-- Create date: 26-November-2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetStageIVNonQualifiedPatient] 
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
			with Denominator_Data AS
			(
				select p.pa_id AS DenomPatient, p.pres_id
				from prescriptions p  WITH(NOLOCK)
				inner join prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
				inner join RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.pres_void = 0 and
				p.pres_approved_date between  @dtstart and @dtend
			),
			Numerator_Data as    
			(    
				select p.pa_id AS NumPatient, p.pres_id
				from prescriptions p  WITH(NOLOCK)
				inner join prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
				inner join RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.pres_delivery_method > 2 and
				p.pres_void = 0 and
				p.pres_approved_date between  @dtstart and @dtend
			)    
			SELECT P.PA_ID AS PATIENT,
				P.PA_FIRST AS FIRSTNAME, 
				P.PA_LAST AS LASTNAME, 
				P.PA_DOB AS DATEOFBIRTH, 
				P.PA_SEX AS SEX,
				P.PA_ADDRESS1 AS ADDRESS1, 
				P.PA_CITY AS CITY,
				P.PA_STATE AS STATE, 
				P.PA_ZIP AS ZIPCODE,
				P.PA_SSN AS CHART
			FROM Denominator_Data DD   WITH(NOLOCK)
			LEFT OUTER JOIN Numerator_Data ND ON DD.DenomPatient = ND.NumPatient
			AND DD.pres_id = ND.pres_id
			INNER JOIN patients P WITH(NOLOCK) ON p.pa_id = DD.DenomPatient
			where ND.NumPatient IS NULL 
		END
		
		IF @MeasureCode='PTE'
		BEGIN
			WITH Denominator_Patient as      
			(
				select p.pa_id AS DenomPatient, p.pres_id
				from prescriptions p  WITH(NOLOCK)
				inner join prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
				inner join RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.pres_void = 0 and
				RV.MED_REF_DEA_CD not in (2,3,4,5) and 
				p.pres_approved_date between  @dtstart and @dtend 
			), 
			Numerator_Patient as      
			(
				select p.pa_id AS NumPatient, p.pres_id
				from prescriptions p  WITH(NOLOCK)
				inner join prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
				inner join RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.pres_delivery_method > 2 and
				p.pres_void = 0 and
				RV.MED_REF_DEA_CD not in (2,3,4,5) and 
				p.pres_approved_date between  @dtstart and @dtend  
			)

			SELECT P.PA_ID AS PATIENT,
				P.PA_FIRST AS FIRSTNAME, 
				P.PA_LAST AS LASTNAME, 
				P.PA_DOB AS DATEOFBIRTH, 
				P.PA_SEX AS SEX,
				P.PA_ADDRESS1 AS ADDRESS1, 
				P.PA_CITY AS CITY,
				P.PA_STATE AS STATE, 
				P.PA_ZIP AS ZIPCODE,
				P.PA_SSN AS CHART
			FROM Denominator_Patient DD   WITH(NOLOCK)
			LEFT OUTER JOIN Numerator_Patient NP ON DD.DenomPatient = NP.NumPatient
			AND DD.pres_id = NP.pres_id
			INNER JOIN patients P WITH(NOLOCK) ON p.pa_id = DD.DenomPatient
			where NP.NumPatient IS NULL 
		END
		
		IF @MeasureCode='CPM'
		BEGIN
			WITH Denominator_Patient as    
			( 
				select p.pa_id AS DenomPatient
				from prescriptions p  WITH(NOLOCK)
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.pres_delivery_method > 2 
				and p.pres_approved_date between  @dtstart and @dtend  

			),    
			Numerator_Patient as    
			(
				select p.pa_id AS NumPatient
				from prescriptions p WITH(NOLOCK) 
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.pres_delivery_method > 2 
				and p.pres_approved_date between  @dtstart and @dtend  
			) 
			

			SELECT  DISTINCT P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN Denominator_Patient DD WITH(NOLOCK) ON P.PA_ID = DD.DenomPatient
			LEFT OUTER JOIN Numerator_Patient ND WITH(NOLOCK) ON P.PA_ID = ND.NumPatient
			WHERE 1=1
			AND ND.NumPatient IS NULL 
		END
		
		IF @MeasureCode='CPL'
		BEGIN
			WITH Denominator_Data as    
			( 
				select p.pat_id AS DenomPatient
				from lab_main p  WITH(NOLOCK)
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.type='Lab'
				and p.message_date between   @dtstart and @dtend 
			),    
			Numerator_Patient as    
			(
				select p.pat_id AS NumPatient
				from lab_main p  WITH(NOLOCK)
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.type='Lab'
				and p.message_date between  @dtstart and @dtend 
			)    
			

			SELECT  DISTINCT P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN Denominator_Data DD WITH(NOLOCK) ON P.PA_ID = DD.DenomPatient
			LEFT OUTER JOIN Numerator_Patient ND WITH(NOLOCK) ON P.PA_ID = ND.NumPatient
			WHERE 1=1
			AND ND.NumPatient IS NULL 
		END
		
		IF @MeasureCode='CPR'
		BEGIN
			WITH Denominator_Data as    
			( 
				select p.pat_id AS DenomPatient
				from lab_main p  WITH(NOLOCK)
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.type='Image'
				and p.message_date between @dtstart and @dtend 
			),    
			Numerator_Data as    
			(
				select p.pat_id AS NumPatient
				from lab_main p  WITH(NOLOCK)
				where 
				((@dg_id IS NULL and p.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
				p.type='Image'
				and p.message_date between @dtstart and @dtend 
			)  
			
			SELECT  DISTINCT P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN Denominator_Data DD WITH(NOLOCK) ON P.PA_ID = DD.DenomPatient
			LEFT OUTER JOIN Numerator_Data ND WITH(NOLOCK) ON P.PA_ID = ND.NumPatient
			WHERE 1=1
			AND ND.NumPatient IS NULL 
		END
		
		IF @MeasureCode='DCP'
		BEGIN 
			WITH DENOMINATOR_PATIENTS as    
			(    
				SELECT  DISTINCT enc.patient_id AS PatientId  
				FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
				INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
				WHERE 1=1 
				AND((@dg_id IS NULL and enc.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND pat.dg_id=@dg_id))
				AND enc.enc_date BETWEEN @dtstart and @dtend   
				AND enc.type_of_visit = 'OFICE'    
				AND	enc.issigned = 1    
			),    

			NUMERATOR_PATIENTS as    
			(    
				SELECT DISTINCT DP.PatientId AS PatientId    
				from  dbo.patient_reg_db  prd  WITH(NOLOCK)    
				INNER JOIN DENOMINATOR_PATIENTS DP  WITH(NOLOCK) ON DP.PatientId  = prd.pa_id
			)  
			
			
			SELECT P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN DENOMINATOR_PATIENTS DD WITH(NOLOCK) ON P.PA_ID = DD.PatientId
			LEFT OUTER JOIN NUMERATOR_PATIENTS ND WITH(NOLOCK) ON P.PA_ID = ND.PatientId
			WHERE 1=1
			AND ND.PatientId IS NULL 
		END
		
		IF @MeasureCode='PAE'
		BEGIN
			WITH DENOMINATOR_PATIENTS AS    
			(    
				SELECT DISTINCT enc.patient_id AS PatientId 
				FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
				INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id 
				INNER JOIN doc_groups DG WITH (NOLOCK) ON DG.dg_id = pat.dg_id    
				INNER JOIN doc_groups DG1 WITH (NOLOCK) ON DG1.dc_id = dg.dc_id 
				WHERE  1=1  
				AND((@dg_id IS NULL and enc.dr_id = @dr_id) OR
				(@dg_id IS NOT NULL AND pat.dg_id=@dg_id))
				AND enc.enc_date BETWEEN @dtstart and @dtend   
				AND	enc.issigned = 1  
			), 
			NUMERATOR_PATIENTS AS    
			(    
				SELECT DISTINCT mc.pa_id as PatientId
				FROM  dbo.MUMeasureCounts mc WITH(NOLOCK)     
				INNER JOIN DENOMINATOR_PATIENTS DP  WITH(NOLOCK)  ON DP.PatientId = mc.pa_id    
				WHERE  1=1  
				AND mc.MeasureCode = @measureCode 
				AND mc.IsNumerator = 1   
				AND mc.DateAdded BETWEEN @dtstart and @dtend     
			)
			
			SELECT  DISTINCT P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN DENOMINATOR_PATIENTS DD WITH(NOLOCK) ON P.PA_ID = DD.PatientId
			LEFT OUTER JOIN NUMERATOR_PATIENTS ND WITH(NOLOCK) ON P.PA_ID = ND.PatientId
			WHERE 1=1
			AND ND.PatientId IS NULL 
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
				AND enc.enc_date BETWEEN @dtstart and @dtend    
				AND enc.type_of_visit = 'OFICE'    
				AND	enc.issigned = 1  
				GROUP BY enc.patient_id
			),  

			NUMERATOR_PATIENTS AS    
			( 
				SELECT pl.pa_id AS PatientId   
				FROM  DENOMINATOR_PATIENTS   DP  WITH(NOLOCK)      
				INNER JOIN dbo.patient_login pl WITH(NOLOCK) ON pl.pa_id = DP.PatientId   
				GROUP BY pl.pa_id
			)
			
			SELECT  DISTINCT 
			P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN DENOMINATOR_PATIENTS DD WITH(NOLOCK) ON P.PA_ID = DD.PatientId
			LEFT OUTER JOIN NUMERATOR_PATIENTS ND WITH(NOLOCK) ON P.PA_ID = ND.PatientId
			WHERE 1=1
			AND ND.PatientId IS NULL 
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
			),
			NUMERATOR_PATIENTS AS    
			(   
				SELECT DISTINCT DP.PatientId AS PatientId  
				FROM  dbo.MUMeasureCounts MDRP    WITH(NOLOCK)
				INNER JOIN  DENOMINATOR_PATIENTS  DP  WITH(NOLOCK) ON  MDRP.pa_id = DP.PatientId 
				INNER JOIN patients pat WITH(NOLOCK) ON DP.PatientId = pat.pa_id
				WHERE 
				((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id))
				AND MDRP.MeasureCode = @meASureCode 
				AND MDRP.IsNumerator = 1 
				AND MDRP.DateAdded  BETWEEN @dtstart AND @dtend  
			)  
			
			SELECT  DISTINCT 
			P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN DENOMINATOR_PATIENTS DD WITH(NOLOCK) ON P.PA_ID = DD.PatientId
			LEFT OUTER JOIN NUMERATOR_PATIENTS ND WITH(NOLOCK) ON P.PA_ID = ND.PatientId
			WHERE 1=1
			AND ND.PatientId IS NULL
			
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
			),    
			NUMERATOR_PATIENTS AS    
			(
				SELECT DISTINCT ppd.pat_id  AS NumPatient
				FROM patient_documents ppd WITH(NOLOCK)
				INNER JOIN DENOMINATOR_PATIENTS den WITH(NOLOCK) ON ppd.pat_id=den.DenomPatient
				INNER JOIN patient_documents_category doc_cat WITH(NOLOCK) ON ppd.cat_id=doc_cat.cat_id
				INNER JOIN doctors doc WITH(NOLOCK) ON ppd.src_dr_id=doc.dr_id
				INNER JOIN patients pat WITH(NOLOCK) ON den.DenomPatient=pat.pa_id
				WHERE 
				((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
				AND ppd.upload_date BETWEEN @dtstart AND @dtend 
				AND doc_cat.title='Patient Portal Documents'
			)  
			
			SELECT  DISTINCT 
			P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN DENOMINATOR_PATIENTS DD WITH(NOLOCK) ON P.PA_ID = DD.DenomPatient
			LEFT OUTER JOIN NUMERATOR_PATIENTS ND WITH(NOLOCK)  ON P.PA_ID = ND.NumPatient
			WHERE 1=1
			AND ND.NumPatient IS NULL
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
			P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN DENOMINATOR_PATIENTS DD ON P.PA_ID = DD.PatientId
			LEFT OUTER JOIN NUMERATOR_PATIENTS ND ON P.PA_ID = ND.PatientId
			WHERE 1=1
			AND ND.PatientId IS NULL
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
			),
			NUMERATOR_PATIENTS AS
			( 	
				SELECT pd.pat_id PatientId
				FROM patient_documents pd WITH(NOLOCK)
				INNER JOIN DENOMINATOR_PATIENTS denom WITH(NOLOCK)  ON denom.PatientId=pd.pat_id
				INNER JOIN doctors doc WITH(NOLOCK)  ON doc.dr_id=pd.src_dr_id
				WHERE 1=1 AND 
				((@dg_id IS  NULL AND pd.src_dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id)) 
				AND pd.cat_id=6  -- Document CCD Type ID
				AND pd.upload_date BETWEEN @dtstart AND @dtend
			) 
			
			SELECT  DISTINCT 
			P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN DENOMINATOR_PATIENTS DD WITH(NOLOCK)  ON P.PA_ID = DD.PatientId
			LEFT OUTER JOIN NUMERATOR_PATIENTS ND WITH(NOLOCK)  ON P.PA_ID = ND.PatientId
			WHERE 1=1
			AND ND.PatientId IS NULL
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
			),
			NUMERATOR_PATIENTS AS    
			(   
				SELECT  DISTINCT MUC.pa_id PatientId    
				FROM  dbo.MUMeasureCounts   MUC  WITH(NOLOCK)    
				INNER JOIN DENOMINATOR_PATIENTS DP WITH(NOLOCK)  ON  DP.PatientId = MUC.pa_id  
				WHERE  1=1 
				AND MUC.MeasureCode    =  @MeasureCode  
				AND MUC.IsNumerator = 1
			)
			
			SELECT  DISTINCT 
			P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
			P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
			FROM PATIENTS P  WITH(NOLOCK) 
			INNER JOIN DENOMINATOR_PATIENTS DD WITH(NOLOCK) ON P.PA_ID = DD.PatientId
			LEFT OUTER JOIN NUMERATOR_PATIENTS ND WITH(NOLOCK) ON P.PA_ID = ND.PatientId
			WHERE 1=1
			AND ND.PatientId IS NULL
		END
		IF @MeasureCode = 'CLR'
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
			DP.is_allergy_reconciled = 0 OR DP.is_allergy_reconciled IS NULL OR
			DP.is_medication_reconciled = 0 OR DP.is_medication_reconciled IS NULL OR
			DP.is_problem_reconciled = 0 OR DP.is_problem_reconciled IS NULL

		END
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
