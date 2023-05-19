SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Nambi
-- Create date: 14/12/2017
-- Description: ACI Numerator Patients
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_NUMERATOR_PATIENTS_IncludeEPCS] 
	@dr_id int, 
	@reporting_start_date date, 
	@reporting_end_date date, 
	@MeasureCode Varchar(3),
	@dg_id int=NULL
AS
BEGIN
SET @reporting_end_date = DATEADD(day, 1, @reporting_end_date )

	IF @MeasureCode<>''
	BEGIN
	
	DECLARE @dr_dgId INT ; 
	DECLARE @dcId AS INT
	
	DECLARE @dc_id INT
 SELECT @dc_id=dg.dc_id FROM doctors d INNER JOIN doc_groups dg ON d.dg_id=dg.dg_id WHERE d.dr_id =  @dr_id ;
	declare @doctor_ids table
		(
			dr_id int,
			dg_id INT
		)
		IF @dg_id IS NULL
	BEGIN
		SELECT @dr_dgId = dg_id FROM dbo.doctors WITH (NOLOCK) where dr_id = @dr_id
		INSERT INTO @doctor_ids (dr_id,dg_id) values (@dr_id,@dr_dgId)
		--INSERT INTO @doctor_ids (dr_id,dg_id)
		--SELECT dr_id,dg_id from doctors where dg_id = @dr_dgId
	END
	ELSE
	BEGIN
		SET @dr_dgId = @dg_id;
		INSERT INTO @doctor_ids (dr_id,dg_id)
		SELECT dr_id,dg_id from doctors where dg_id = @dg_id
	END; 
	SELECT @dcId = dc_id FROM dbo.doc_groups WITH (NOLOCK) where dg_id = @dr_dgId;
	
	
		IF @MeasureCode= 'EPR'
		BEGIN
			with Denominator_Data as    
			 ( 
			 
			  select p.pa_id AS DenomPatient
			  from prescriptions p 
			  inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
			  inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
			  where 
			  ((@dg_id IS NULL and p.dr_id = @dr_id) OR
			  (@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			  p.pres_void = 0 and
			  p.pres_approved_date between @reporting_start_date and @reporting_end_date
			 ),    
			 Numerator_Data as    
			 (
			  select p.pa_id AS NumPatient
			  from prescriptions p 
			  inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
			  inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
			  where 
			  ((@dg_id IS NULL and p.dr_id = @dr_id) OR
			  (@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			  p.pres_delivery_method > 2 and
			  p.pres_void = 0 and
			  p.pres_approved_date between @reporting_start_date and @reporting_end_date 
			  
			 ) 
			
			   select 
			   pa_id as Patient,
			   pa_first as FirstName,
			   pa_last as LastName,
			   pat.pa_dob as DateOfBirth,
			   pa_sex as sex,
			   pa_address1 as Address1,
			   pa_city as City,
			   pa_state as [State],
			   pa_zip as ZipCode,
			   pa_ssn as chart
			   from  dbo.Patients    PAT  with(nolock)
			   INNER JOIN Numerator_Data dp WITH(NOLOCK) ON PAT.pa_id=dp.NumPatient			
		END
		
		IF @MeasureCode= 'PPD'
		BEGIN
			WITH Denominator_Data AS    
			 ( 
			  SELECT DISTINCT enc.patient_id as DenomPatient 
			  FROM enchanced_encounter enc WITH(NOLOCK)
			  INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
			  INNER JOIN doc_groups dg WITH(NOLOCK) ON doc.dg_id=dg.dg_id
  INNER JOIN doc_groups dg1 WITH(NOLOCK) ON dg.dc_id=dg.dc_id
			  WHERE 
			  ((@dg_id IS NULL AND enc.dr_id = @dr_id) OR
			  (@dg_id IS NOT NULL AND dg1.dg_id=@dg_id)) AND
			  enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
			  AND enc.issigned=1  
			 ),    
			 Numerator_Patient AS    
			 (
			  SELECT DISTINCT ppd.pat_id  AS NumerPatient
  FROM patient_documents ppd WITH(NOLOCK)
  INNER JOIN Denominator_Data den WITH(NOLOCK) ON ppd.pat_id=den.DenomPatient
  INNER JOIN doctors doc WITH(NOLOCK) ON ppd.src_dr_id=doc.dr_id
  INNER JOIN patients pat WITH(NOLOCK) ON den.DenomPatient=pat.pa_id
  INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
  INNER JOIN doc_groups dg1 WITH(NOLOCK) ON dg.dc_id=dg.dc_id
  WHERE 
  ((@dg_id IS NULL AND ppd.src_dr_id = @dr_id) OR
	(@dg_id IS NOT NULL AND dg1.dg_id=@dg_id)) AND
	ppd.upload_date BETWEEN @reporting_start_date AND @reporting_end_date 
  AND ppd.cat_id=11
			 )
			
			   select 
			   pa_id as Patient,
			   pa_first as FirstName,
			   pa_last as LastName,
			   pat.pa_dob as DateOfBirth,
			   pa_sex as sex,
			   pa_address1 as Address1,
			   pa_city as City,
			   pa_state as [State],
			   pa_zip as ZipCode,
			   pa_ssn as chart
			   from  dbo.Patients    PAT  with(nolock) where 1=1
			   AND pat.pa_id in 
			   ( 
					select distinct 
					dp.NumerPatient from Numerator_Patient dp
			   )			
		END
		
		IF @MeasureCode= 'PAC'
			BEGIN
				with patient_encounters as    
				(   
					select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
					from  dbo.enchanced_encounter  enc  with(nolock)    
					inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
					where  
				   ((@dg_id IS NULL and enc.dr_id = @dr_id) OR
				   (@dg_id IS NOT NULL AND pat.dg_id=@dg_id)) AND 1=1    
					and   enc.dr_id  = @dr_id  
					and   enc.enc_date between @reporting_start_date and @reporting_end_date 
					AND	ENC.issigned = 1   
					group by enc.patient_id, enc.dr_id    
				),
				Numerator_Data as    
				(    
				  select distinct pec.patient_id 
				  from  dbo.patient_reg_db  prd  with(nolock)    
				  inner join patient_encounters  pec  with(nolock) on pec.patient_id  = prd.pa_id    
				  where  1=1    
				  --and   prd.dr_id  = @dr_id 
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Numerator_Data den with(nolock)
				left join patients p on p.pa_id=den.patient_id
			END
		
		IF @MeasureCode= 'MDR'
			BEGIN
				WITH DENOMINATOR_PATIENT AS      
				(
					 -- SELECT DISTINCT pat.pa_id DenomPatient
					-- FROM	dbo.patients    pat  WITH (NOLOCK)
					-- INNER JOIN doc_groups DG WITH (NOLOCK) ON DG.dg_id = pat.dg_id
					-- INNER JOIN dbo.patient_extended_details ped WITH (NOLOCK) on ped.pa_id  = pat.pa_id 
					-- INNER JOIN doc_groups DG1 WITH (NOLOCK) ON DG1.dc_id = dg.dc_id
					-- where   ((ISNULL(@dg_id, 0) <= 0 AND DG1.dc_id = @dc_Id) OR --Filtering based on Dc_id
					-- (ISNULL(@dg_id, 0) > 0 AND dg1.dg_id = @dr_dgId)) --Filtering based on Dg_id
					-- AND ped.pa_ext_ref = 1 AND ped.prim_dr_id IS not NULL
					-- AND ped.pa_ref_date  BETWEEN @reporting_start_date AND @EndDate
					SELECT rcve.pa_id DenomPatient
					FROM direct_email_receive_messages rcve WITH(NOLOCK)
					INNER JOIN doctors doc WITH(NOLOCK) ON doc.dr_id=rcve.dr_id
					WHERE ((@dg_id IS NULL and rcve.dr_id = @dr_id) OR
						(@dg_id IS NOT NULL AND doc.dg_id=@dg_id)) AND
						rcve.type LIKE 'Referral' AND rcve.is_ccd=1
						AND rcve.created_on BETWEEN @reporting_start_date AND @reporting_end_date
					
				),
				
				Numerator_Patient as    
				( 	  
					-- SELECT MDRP.pa_id  AS NumeratorPatient
					-- FROM  dbo.MUMeasureCounts MDRP    WITH(NOLOCK)
					-- INNER JOIN  DENOMINATOR_PATIENT  DP  WITH(NOLOCK) ON  MDRP.pa_id = DP.DenomPatient AND MDRP.MeasureCode = 'MDP' and MDRP.IsNumerator = 1 and  MDRP.DateAdded  between @reporting_start_date and @EndDate    
					-- INNER JOIN  dbo.MUMeasureCounts MDRA  WITH(NOLOCK) ON MDRA.pa_id = DP.DenomPatient AND MDRA.MeasureCode = 'MDA' and MDRA.IsNumerator = 1 and  MDRA.DateAdded  between @reporting_start_date and @EndDate    
					-- INNER JOIN  dbo.MUMeasureCounts MDRM  WITH(NOLOCK) ON MDRM.pa_id = DP.DenomPatient AND MDRM.MeasureCode = 'MDM' and MDRM.IsNumerator = 1 and  MDRM.DateAdded  between @reporting_start_date and @EndDate    
					SELECT rcve.pa_id NumeratorPatient
					FROM direct_email_receive_messages rcve WITH(NOLOCK)
					INNER JOIN doctors doc WITH(NOLOCK) ON doc.dr_id=rcve.dr_id
					WHERE ((@dg_id IS NULL and rcve.dr_id = @dr_id) OR
						(@dg_id IS NOT NULL AND doc.dg_id=@dg_id)) AND
						rcve.type LIKE 'Referral' AND rcve.is_ccd=1 AND rcve.is_incorporated=1
						AND med_reconciled=1 AND problem_reconciled=1 AND allergy_reconciled=1
						AND rcve.created_on BETWEEN @reporting_start_date AND @reporting_end_date
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Numerator_Patient num with(nolock)
				left join patients p on p.pa_id=num.NumeratorPatient
		
			END
		
		IF @MeasureCode= 'SEM'	
			BEGIN
				with patient_encounters as    
				( 
					select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
					from  dbo.enchanced_encounter  enc  with(nolock)    
					inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
					where  1=1 AND
					((@dg_id IS NULL and enc.dr_id = @dr_id) OR
				   (@dg_id IS NOT NULL AND pat.dg_id=@dg_id))
					and   enc.enc_date between @reporting_start_date and @reporting_end_date    
					and   enc.type_of_visit = 'OFICE'    
					and	enc.issigned = 1
					group by enc.patient_id, enc.dr_id
				),
				Numerator_Data as    
				( 
					  select  mc.pa_id   
					  from  dbo.MUMeasureCounts mc with(nolock)    
					  inner join patient_encounters  enc  with(nolock) on enc.patient_id = mc.pa_id    
					  where  1=1   AND
					((@dg_id IS NULL and mc.dr_id = @dr_id) OR
				   (@dg_id IS NOT NULL AND mc.dg_id=@dg_id))
					  and mc.MeasureCode = @measureCode    
					  and mc.DateAdded between @reporting_start_date and @reporting_end_date 
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Numerator_Data den with(nolock)
				left join patients p on p.pa_id=den.pa_id
							
			END
		
		IF @MeasureCode= 'PAE'
			BEGIN
				 
	   
				 WITH DENOMINATOR_PATIENT AS    
				 (    
					  SELECT DISTINCT enc.patient_id AS PatientId 
					  FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
					  INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id    
					  WHERE  1=1  AND  
					  ((@dg_id IS NULL AND enc.dr_id = @dr_id) OR
					  (@dg_id IS NOT NULL AND pat.dg_id=@dg_id))  
					  AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date  
					  AND	enc.issigned = 1  
				 ), 
				 NUMERATOR_PATIENT AS    
				 (    
					  SELECT DISTINCT mc.pa_id as PatientId
					  FROM  dbo.MUMeasureCounts mc WITH(NOLOCK)     
					  INNER JOIN DENOMINATOR_PATIENT DP  WITH(NOLOCK)  ON DP.PatientId = mc.pa_id    
					  WHERE  1=1  
					  AND mc.MeasureCode = @measureCode 
					  AND mc.IsNumerator = 1   
					  AND mc.DateAdded BETWEEN @reporting_start_date AND @reporting_end_date   
				 )
			    
				SELECT p.pa_id AS Patient,p.pa_first AS FirstName,p.pa_last AS LastName,p.pa_dob AS DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				FROM NUMERATOR_PATIENT NP with(nolock)
				left join patients p ON p.pa_id=NP.PatientId
				
			END
		
		IF @MeasureCode= 'VDT'
			BEGIN
				WITH DENOMINATOR_PATIENTS AS    
				(    
					SELECT  DISTINCT enc.patient_id AS PatientId  
					FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
					INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
					INNER JOIN doc_groups DG WITH (NOLOCK) ON DG.dg_id = pat.dg_id
					INNER JOIN doc_groups DG1 WITH (NOLOCK) ON DG1.dc_id = dg.dc_id
					WHERE 1=1 
					AND	((ISNULL(@dg_id, 0) <= 0 AND enc.dr_id = @dr_id) OR --Filtering based on Dr_id
						(ISNULL(@dg_id, 0) > 0 AND dg1.dg_id = @dr_dgId)) --Filtering based on Dg_id
					AND enc.enc_date BETWEEN @reporting_start_date and @reporting_end_date    
					AND enc.type_of_visit = 'OFICE'    
					AND	enc.issigned = 1 
				),
				
				NUMERATOR_PATIENTS AS    
				( 
					SELECT DISTINCT DP.PatientId AS PatientId   
					FROM  DENOMINATOR_PATIENTS   DP  WITH(NOLOCK)      
					INNER JOIN dbo.patient_login pl WITH(NOLOCK) ON pl.pa_id = DP.PatientId   
				)  
				
				SELECT 
					p.pa_id AS Patient,
					p.pa_first AS FirstName,
					p.pa_last AS LastName,
					p.pa_dob AS DateOfBirth,
					p.pa_sex AS sex,
					p.pa_address1 AS Address1,
					p.pa_city AS City,
					p.pa_state AS [State],
					p.pa_zip AS ZipCode,
					p.pa_ssn AS chart  
				FROM NUMERATOR_PATIENTS NP with(nolock)
				left join patients p on p.pa_id=NP.PatientId
			END	
		
		IF @MeasureCode= 'HIE'	
			BEGIN
				with patient_referrals as    
				( 
				  select  rm.pa_id as patient_id, rm.main_dr_id as dr_id, rm.ref_id   
				  from  referral_main  rm  with(nolock)    
				  --INNER JOIN doctors doc WITH(NOLOCK) ON rm.main_dr_id=doc.dr_id
				  INNER JOIN patients pat WITH(NOLOCK) ON   rm.pa_id=pat.pa_id
				  inner join @doctor_ids d on d.dr_id = rm.main_dr_id 
				  --INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
				  where  1=1 
				  --AND dg.dc_id=@dc_id 
				  --AND ((@dg_id IS NULL AND rm.main_dr_id = @dr_id) OR
					--(@dg_id IS NOT NULL AND dg.dg_id=@dg_id)) 
					  and   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
				  group by rm.pa_id, rm.main_dr_id , rm.ref_id  
				),
				Numerator_Data as    
				( 
					select DISTINCT  pat.patient_id  As PatientId, pat.dr_id, pat.ref_id--, MUC.Id
					from  patient_referrals    pat
					
					where  1=1
						AND EXISTS (SELECT * FROM  dbo.direct_email_sent_messages de with(nolock) 
						WHERE de.attachment_type = 'CCD' AND pat.ref_id=de.ref_id
						and	  de.send_success = 1 
						and   de.sent_date between @reporting_start_date and @reporting_end_date   
						AND de.pat_id = pat.patient_id
						)
						--AND EXISTS(SELECT * FROM  dbo.MUMeasureCounts MUC WHERE MUC.pa_id = pat.patient_id AND pat.dr_id=MUC.dr_id
						--and   MUC.IsNumerator = 1 
						--and   MUC.dr_id  = pat.dr_id
						--and   MUC.MeasureCode = 'SC2'
						--and	  MUC.DateAdded  between @reporting_start_date and @reporting_end_date
						--AND ((@dg_id IS NULL AND MUC.dr_id = @dr_id) OR
					--(@dg_id IS NOT NULL AND MUC.dg_id=@dg_id)) 
						--)
					group by pat.patient_id , pat.dr_id, pat.ref_id
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Numerator_Data den with(nolock)
				left join patients p on p.pa_id=den.PatientId
			END
			
		IF @MeasureCode= 'RIC'	
			BEGIN
				with Denominator_Data AS    
				( 	    
					--SELECT pat.pa_id PatientId
					--FROM	dbo.patients    pat  WITH (NOLOCK)
					--INNER JOIN dbo.patient_extended_details ped WITH (NOLOCK) on ped.pa_id  = pat.pa_id 
					--INNER JOIN dbo.doc_groups dg ON  dg.dg_id=pat.dg_id
					--INNER JOIN dbo.doc_companies dc ON  dg.dc_id=dg.dc_id
					--INNER JOIN dbo.doc_groups dg1 ON  dg1.dc_id=dc.dc_id
					--INNER JOIN @doctor_ids drs ON  drs.dg_id=dg1.dg_id
					--where dg.dc_id=@dc_id AND ped.pa_ext_ref = 1 --AND ISNULL(ped.prim_dr_id ,0)>0
					--AND ped.pa_ref_date  BETWEEN @reporting_start_date AND @EndDate 
					SELECT rcve.pa_id PatientId
					FROM direct_email_receive_messages rcve WITH(NOLOCK)
					INNER JOIN doctors doc WITH(NOLOCK) ON doc.dr_id=rcve.dr_id
					WHERE ((@dg_id IS NULL and rcve.dr_id = @dr_id) OR
					(@dg_id IS NOT NULL AND doc.dg_id=@dg_id)) AND
					rcve.type LIKE 'Referral' AND rcve.is_ccd=1
					AND rcve.created_on BETWEEN @reporting_start_date AND @reporting_end_date
				),
				Numerator_Data AS
				( 	   
					--SELECT	DISTINCT A.pat_id AS PatientId
					--FROM	Denominator_Data REF WITH (NOLOCK)
					--INNER JOIN patient_documents A WITH (NOLOCK) on a.pat_id = REF.PatientId
					--INNER JOIN @doctor_ids drs ON  drs.dr_id=A.src_dr_id
					--INNER JOIN PATIENT_DOCUMENTS_CATEGORY B ON A.CAT_ID = B.CAT_ID 
		
					--WHERE	1 = 1 
					--AND A.src_dr_id = @dr_id 
					--AND A.UPLOAD_DATE BETWEEN @reporting_start_date AND @EndDate
					--AND B.title = 'External CCR/CCD Documents'
					SELECT rcve.pa_id PatientId
					FROM direct_email_receive_messages rcve WITH(NOLOCK)
					INNER JOIN doctors doc WITH(NOLOCK) ON doc.dr_id=rcve.dr_id
					WHERE ((@dg_id IS NULL and rcve.dr_id = @dr_id) OR
					(@dg_id IS NOT NULL AND doc.dg_id=@dg_id)) AND
					rcve.type LIKE 'Referral' AND rcve.is_ccd=1 AND rcve.is_incorporated=1
					AND rcve.created_on BETWEEN @reporting_start_date AND @reporting_end_date
				)   
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
					from Numerator_Data den with(nolock)
					left join patients p on p.pa_id=den.PatientId
			END
		
		IF @MeasureCode= 'DCP'	
			BEGIN
				with DENOMINATOR_PATIENTS as    
					(    
						SELECT  DISTINCT enc.patient_id AS PatientId 
						FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
						INNER JOIN dbo.patients pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id    
						WHERE  ((@dg_id IS NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT NULL AND pat.dg_id=@dg_id))   
						AND enc.dtsigned BETWEEN @reporting_start_date and @reporting_end_date 
						AND	ENC.issigned = 1     
					),		
					Numerator_Data AS
					( 	   
						SELECT DISTINCT DP.PatientId AS PatientId    
						from  dbo.patient_reg_db  prd  WITH(NOLOCK)    
						INNER JOIN DENOMINATOR_PATIENTS DP  WITH(NOLOCK) ON DP.PatientId  = prd.pa_id
					)  
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
					from Numerator_Data den with(nolock)
					left join patients p on p.pa_id=den.PatientId
		END
		
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
