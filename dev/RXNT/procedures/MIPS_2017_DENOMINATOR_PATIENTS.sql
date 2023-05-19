SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MIPS_2017_DENOMINATOR_PATIENTS] 
	@dr_id int, 
	@reporting_start_date date, 
	@reporting_end_date date, 
	@MeasureCode Varchar(3) 
AS
BEGIN
	IF @MeasureCode<>''
	BEGIN
		
		IF @MeasureCode = 'EPR'
		BEGIN
			with Denominator_Patient as 
			(
				  select distinct pa_id as DenomPatient 
				  from prescriptions p 
				  inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
				  inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
				  where 
				  p.dr_id = @dr_id and 
				  p.pres_delivery_method > 2 and
				  p.pres_void = 0 and
				  RV.MED_REF_DEA_CD not in (2,3,4,5) and 
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
			   from  dbo.Patients    PAT  with(nolock) where 1=1
			   AND pat.pa_id in 
			   ( 
					select distinct 
					dp.DenomPatient from Denominator_Patient dp
			   )			
		END
		
		IF @MeasureCode='PAC'
			BEGIN
				with patient_encounters as    
				(    
				select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @reporting_start_date and @reporting_end_date 
				AND	ENC.issigned = 1   
				group by enc.patient_id, enc.dr_id    
				),
				Denominator_Data as    
				(    
				select  distinct enc.patient_id  
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @reporting_start_date and @reporting_end_date 
				and	enc.issigned = 1  
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den with(nolock)
				left join patients p on p.pa_id=den.patient_id
			END
			
		IF @MeasureCode= 'MDR'
			BEGIN
				
				select  p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
				from  dbo.patients    p    
				inner join dbo.patient_extended_details ped with(nolock) on ped.pa_id  = p.pa_id 
				inner join	
					(
						select dg_id from doc_groups DG with(nolock) 
									inner join
									(select DG.dc_id dc_id from doctors DR with(nolock)
															inner join doc_groups DG with(nolock) on DR.dg_id = DG.dg_id
															inner join doc_companies DC with(nolock) on DG.dc_id=DC.dc_id
															where DR.dr_id = @dr_id
									)DCS on DG.dc_id = DCS.dc_id
					) DGS on p.dg_id = DGS.dg_id
				where  1=1    
				and   ped.pa_ext_ref = 1
				and   ped.pa_ref_date  between @reporting_start_date and @reporting_end_date      
		
			END
		
		IF @MeasureCode= 'SEM'	
			BEGIN
				with patient_encounters as    
				( 
					select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
					from  dbo.enchanced_encounter  enc  with(nolock)    
					inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
					where  1=1    
					and   enc.dr_id  = @dr_id    
					and   enc.enc_date between @reporting_start_date and @reporting_end_date    
					and   enc.type_of_visit = 'OFICE'    
					and	enc.issigned = 1
					group by enc.patient_id, enc.dr_id
				),
				Denominator_Data as    
				( 
					select  distinct pen.patient_id
					from  patient_encounters   pen  with(nolock)    
					inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id    
					where  1=1     
					group by pen.patient_id, pen.dr_id
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den with(nolock)
				left join patients p on p.pa_id=den.patient_id
							
			END
			
		IF 	@MeasureCode= 'PAE'
			BEGIN
				with patient_encounters as    
				( 
					select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
					from  dbo.enchanced_encounter  enc  with(nolock)    
					inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
					where  1=1    
					and   enc.dr_id  = @dr_id    
					and   enc.enc_date between @reporting_start_date and @reporting_end_date  
					and	enc.issigned = 1  
					group by enc.patient_id, enc.dr_id 
				),
				Denominator_Data as    
				( 
					  select  distinct enc.patient_id    
					  from  dbo.enchanced_encounter  enc  with(nolock)    
					  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
					  where  1=1    
					  and   enc.dr_id  = @dr_id    
					  and   enc.enc_date between @reporting_start_date and @reporting_end_date 
					  and	enc.issigned = 1   
					  group by enc.patient_id 
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den with(nolock)
				left join patients p on p.pa_id=den.patient_id
				
			END
			
		IF @MeasureCode= 'VDT'
			BEGIN
				with patient_encounters as    
				( 
					select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
					  from  dbo.enchanced_encounter  enc  with(nolock)    
					  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
					  where  1=1    
					  and   enc.dr_id  = @dr_id    
					  and   enc.enc_date between @reporting_start_date and @reporting_end_date    
					  and   enc.type_of_visit = 'OFICE'    
					  and	enc.issigned = 1
					  group by enc.patient_id, enc.dr_id  
				),
				Denominator_Data as    
				( 
					  select  distinct pen.patient_id
					  from  patient_encounters   pen  with(nolock)    
					  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id    
					  where  1=1     
					  group by pen.patient_id  
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den with(nolock)
				left join patients p on p.pa_id=den.patient_id
			END	
		IF @MeasureCode= 'HIE'	
			BEGIN
				with patient_encounters as    
				( 
					select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
				  from  dbo.enchanced_encounter  enc  with(nolock)    
				  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id   
				  inner join referral_main   rm   with(nolock) on rm.pa_id   = pat.pa_id 
				  where  1=1    
				  and   enc.dr_id  = @dr_id    
				  and   enc.enc_date between @reporting_start_date and @reporting_end_date    
				  and   enc.type_of_visit = 'OFICE'    
				  and	enc.issigned = 1
				  and   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
				  group by enc.patient_id, enc.dr_id 
				),
				Denominator_Data as    
				( 
					  select  distinct pen.patient_id
					  from  patient_encounters   pen  with(nolock)    
					  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id 
					  inner join referral_main   rm   with(nolock) on rm.pa_id   = pat.pa_id    
					  where  1=1     
					  group by pen.patient_id  
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den with(nolock)
				left join patients p on p.pa_id=den.patient_id
			END
		
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
