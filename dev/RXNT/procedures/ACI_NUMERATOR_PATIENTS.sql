SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Niyas
-- Create date: 14/12/2017
-- Description: ACI Numerator Patients
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_NUMERATOR_PATIENTS]
	@dr_id INT, 
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@MeasureCode VARCHAR(3),
	@dg_id INT=NULL
AS
BEGIN
--SET @reporting_end_date = DATEADD(day, 1, @reporting_end_date )

	DECLARE @dr_dgId INT ; 
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
	 DECLARE @dc_id INT
 SELECT @dc_id=dg.dc_id FROM doctors d INNER JOIN doc_groups dg ON d.dg_id=dg.dg_id WHERE d.dr_id =  @dr_id ;
	

	DECLARE  @EndDate DATE = DATEADD(DAY,1,@reporting_end_date)
	IF @MeasureCode<>''
	BEGIN
	
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
			  RV.MED_REF_DEA_CD not in (2,3,4,5) and 
			  p.pres_approved_date between @reporting_start_date and @EndDate
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
			  RV.MED_REF_DEA_CD not in (2,3,4,5) and 
			  p.pres_approved_date between @reporting_start_date and @EndDate 
			  
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
  WHERE 
  ((@dg_id IS NULL AND enc.dr_id = @dr_id) OR
  (@dg_id IS NOT NULL AND doc.dg_id=@dg_id)) AND
  enc.enc_date BETWEEN @reporting_start_date AND @EndDate
  AND enc.issigned=1  
 )	, 
			 Numerator_Data AS    
			 (
			SELECT DISTINCT ppd.pat_id  AS NumPatient
  FROM patient_documents ppd WITH(NOLOCK)
  INNER JOIN Denominator_Data den WITH(NOLOCK) ON ppd.pat_id=den.DenomPatient
  INNER JOIN doctors doc WITH(NOLOCK) ON ppd.src_dr_id=doc.dr_id
  INNER JOIN patients pat WITH(NOLOCK) ON den.DenomPatient=pat.pa_id
  INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
  --INNER JOIN doc_groups dg1 WITH(NOLOCK) ON dg.dc_id=dg.dc_id
  WHERE 
  dg.dc_id=@dc_id AND
  --((@dg_id IS NULL AND ppd.src_dr_id = @dr_id) OR
--	(@dg_id IS NOT NULL AND dg1.dg_id=@dg_id)) AND
	ppd.upload_date BETWEEN @reporting_start_date AND @EndDate 
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
					dp.NumPatient from Numerator_Data dp
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
					and   enc.enc_date between @reporting_start_date and @EndDate 
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
				WITH DENOMINATOR_PATIENTS AS      
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
				
				Numerator_Patient as    
				( 	
					SELECT  DISTINCT MUC.pa_id PatientId    
					FROM  dbo.MUMeasureCounts   MUC  WITH(NOLOCK)    
					INNER JOIN DENOMINATOR_PATIENTS DP  ON  DP.PatientId = MUC.pa_id  
					WHERE  1=1 
					AND MUC.MeasureCode    =  @MeasureCode  
					AND MUC.IsNumerator = 1
		)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Numerator_Patient num with(nolock)
				left join patients p on p.pa_id=num.PatientId
		
			END
		
		IF @MeasureCode= 'SEM'	
			BEGIN
				with patient_encounters as    
				( 
					SELECT DISTINCT enc.patient_id as PatientId 
				  FROM enchanced_encounter enc WITH(NOLOCK)
				  INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
				  INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id=doc.dg_id
				  INNER JOIN doc_groups dg1 WITH(NOLOCK) ON dg1.dc_id=dg.dc_id
				  WHERE dg.dc_id=@dc_id AND
				  ((@dg_id IS NULL AND enc.dr_id = @dr_id) OR
				  (@dg_id IS NOT NULL AND dg1.dg_id=@dr_dgId) )
				  AND
				  enc.enc_date BETWEEN @reporting_start_date AND @EndDate
				  AND enc.issigned=1  	
				 ),
				Numerator_Data as    
				( 
					SELECT DISTINCT DP.PatientId  
				FROM  dbo.MUMeasureCounts MDRP    WITH(NOLOCK)
				INNER JOIN  patient_encounters  DP  WITH(NOLOCK) ON  MDRP.pa_id = DP.PatientId 
				INNER JOIN doctors doc WITH(NOLOCK) ON MDRP.dr_id=doc.dr_id
				INNER JOIN patients pat WITH(NOLOCK) ON DP.PatientId = pat.pa_id
				INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
				WHERE dg.dc_id=@dc_id AND MDRP.MeasureCode = @meASureCode and MDRP.IsNumerator = 1 and  
				MDRP.DateAdded  between @reporting_start_date and @EndDate    
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Numerator_Data den with(nolock)
				left join patients p on p.pa_id=den.PatientId
							
			END
		
		IF @MeasureCode= 'PAE'
			BEGIN
	   
				 WITH DENOMINATOR_PATIENT AS    
				 (    
					  SELECT DISTINCT enc.patient_id AS PatientId 
					  FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
					  INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id   
					  INNER JOIN doc_groups DG WITH (NOLOCK) ON DG.dg_id = pat.dg_id  
					  INNER JOIN doc_groups DG1 WITH (NOLOCK) ON DG1.dc_id = dg.dc_id     
					  WHERE  1=1   
						and	((ISNULL(@dg_id, 0) <= 0 AND enc.dr_id = @dr_id) OR --Filtering based on Dr_id
							(ISNULL(@dg_id, 0) > 0 AND dg.dg_id = @dr_dgId)) --Filtering based on Dg_id   
					  AND enc.enc_date BETWEEN @reporting_start_date AND @EndDate  
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
					  AND mc.DateAdded BETWEEN @reporting_start_date AND @EndDate   
				 )
			    
				SELECT p.pa_id AS Patient,p.pa_first AS FirstName,p.pa_last AS LastName,p.pa_dob AS DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				FROM NUMERATOR_PATIENT NP with(nolock)
				left join patients p ON p.pa_id=NP.PatientId
				
			END
		
		IF @MeasureCode= 'VDT'
			BEGIN
				WITH DENOMINATOR_PATIENTS AS    
				( SELECT  DISTINCT enc.patient_id AS PatientId  
					FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
					INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
					INNER JOIN doc_groups DG WITH (NOLOCK) ON DG.dg_id = pat.dg_id
					INNER JOIN doc_groups DG1 WITH (NOLOCK) ON DG1.dc_id = dg.dc_id
					WHERE 1=1 
					AND	((ISNULL(@dg_id, 0) <= 0 AND enc.dr_id = @dr_id) OR --Filtering based on Dr_id
						(ISNULL(@dg_id, 0) > 0 AND dg1.dg_id = @dr_dgId)) --Filtering based on Dg_id
					AND enc.enc_date BETWEEN @reporting_start_date and @EndDate    
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
					  and   rm.ref_start_date between @reporting_start_date and @EndDate  
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
						and   de.sent_date between @reporting_start_date and @EndDate   
						AND de.pat_id = pat.patient_id
						)
						--AND EXISTS(SELECT * FROM  dbo.MUMeasureCounts MUC WHERE MUC.pa_id = pat.patient_id AND pat.dr_id=MUC.dr_id
						--and   MUC.IsNumerator = 1 
						--and   MUC.dr_id  = pat.dr_id
						--and   MUC.MeasureCode = 'SC2'
						--and	  MUC.DateAdded  between @reporting_start_date and @EndDate
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
				with DENOMINATOR_PATIENTS AS    
				( 		
					SELECT enc.patient_id as DenomPatient, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob      
					FROM dbo.enchanced_encounter enc WITH(NOLOCK)      
					INNER JOIN dbo.patients pat WITH(NOLOCK) ON pat.pa_id=enc.patient_id     
					INNER JOIN referral_main   rm   with(nolock) on rm.pa_id   = pat.pa_id 
					WHERE 1=1
					AND   enc.dr_id  = @dr_id    
					AND   enc.enc_date between @reporting_start_date and @reporting_end_date    
					AND   enc.type_of_visit = 'OFICE'    
					AND	  enc.issigned = 1
					and   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
					GROUP BY  enc.patient_id, enc.dr_id ,pat.pa_dob  ),
					NUMERATOR_PATIENTS AS
				( 
					SELECT DISTINCT DP.DenomPatient as NumPatient 
					FROM  dbo.direct_email_sent_messages de with(nolock) 
					INNER JOIN DENOMINATOR_PATIENTS DP ON DP.DenomPatient=de.pat_id
					WHERE de.attachment_type = 'CCD' and	  de.send_success = 1 
					AND   de.sent_date between @reporting_start_date and @reporting_end_date 
				)  
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
					from NUMERATOR_PATIENTS den with(nolock)
					left join patients p on p.pa_id=den.NumPatient
			END
		
		IF @MeasureCode= 'DCP'	
			BEGIN
				with DENOMINATOR_PATIENTS as    
					(    
						SELECT  DISTINCT enc.patient_id AS PatientId 
						FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
						INNER JOIN dbo.patients pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id    
						WHERE  ((@dg_id IS NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT NULL AND pat.dg_id=@dr_dgId))   
						AND enc.dtsigned BETWEEN @reporting_start_date and @EndDate 
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
