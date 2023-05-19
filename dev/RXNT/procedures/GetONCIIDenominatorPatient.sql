SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetONCIIDenominatorPatient] 
	@dr_id int, 
	@dtstart date, 
	@dtend date, 
	@MeasureCode Varchar(3),
	@exclusion int   
AS
BEGIN
	IF @MeasureCode<>''
	BEGIN
		IF @MeasureCode='CPM'
			BEGIN
				SELECT p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				FROM  dbo.MUMeasureCounts   MUC  with(nolock)  
				left join patients p on p.pa_id=MUC.pa_id     
				WHERE  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.DateAdded between @dtstart and @dtend  
			END
		IF @MeasureCode='CPR'
			BEGIN
				SELECT p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart        
				from  dbo.MUMeasureCounts   MUC  with(nolock)
				left join patients p on p.pa_id=MUC.pa_id      
				where  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.RecordCreateDateTime between @dtstart and @dtend 
			END	
		IF @MeasureCode='CPL'
			BEGIN
				SELECT p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart             
				from  dbo.MUMeasureCounts   MUC  with(nolock) 
				left join patients p on p.pa_id=MUC.pa_id      
				where  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.RecordCreateDateTime between @dtstart and @dtend 
			END
		IF @MeasureCode='PTE'
			BEGIN
			  select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart                 
			  from  dbo.prescriptions   prx with(nolock)    
			  inner join dbo.prescription_details pxd with(nolock) on pxd.pres_id  = prx.pres_id    
			  inner join dbo.RMIID1     rd1 with(nolock)  on rd1.medid  = pxd.ddid 
			  left join patients p on p.pa_id=prx.pa_id   
			  where  1=1    
			  and   prx.dr_id     = @dr_id    
			  and   prx.pres_entry_date   between  @dtstart and @dtend    
			  and   prx.pres_void    = 0 
			  and	prx.pres_approved_date is not null   
			  and   rd1.MED_REF_DEA_CD   < 2
			END
		IF @MeasureCode='DMG'
			BEGIN
				 with patient_encounters as    
				 (    
				  select  enc.patient_id, enc.dr_id    
				  from  dbo.enchanced_encounter  enc  with(nolock)    
				  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				  where  1=1    
				  and   enc.dr_id  = @dr_id    
				  and   enc.enc_date between @dtstart and @dtend  
				  and enc.issigned = 1  
				  group by enc.patient_id, enc.dr_id    
				 )
				 
				  select distinct enc.patient_id AS Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart    
				  from  patient_encounters enc   
				  inner join dbo.patients  p  with(nolock) on p.pa_id  = enc.patient_id    
				  where  1=1    
				  and   enc.dr_id  = @dr_id
			END
		IF @MeasureCode='VTL'
			BEGIN
				 with patient_encounters as    
				 (    
				  select  enc.patient_id,DATEDIFF(YEAR, pa_dob,MAX(enc.enc_date)) as Age    
				  from  dbo.enchanced_encounter  enc  with(nolock)    
				  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				  where  1=1    
				  and   enc.dr_id  = @dr_id    
				  and   enc.enc_date between @dtstart and @dtend    
				  and enc.issigned = 1
				  group by enc.patient_id, enc.dr_id, pat.pa_dob    
				 )
				 
				 select pe.patient_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart    
				 from patient_encounters pe
				 left join patients p on p.pa_id=pe.patient_id 
				 where pe.Age>=(case 
				 when @exclusion=2 then
					2
				 else 
					0
				 end)
			END
		IF @MeasureCode='SMK'
			BEGIN
				 with patient_encounters as    
				 (    
				 select  enc.patient_id, enc.dr_id, DATEDIFF(YEAR, pa_dob, MAX(enc.enc_date)) as Age  
				  from  dbo.enchanced_encounter  enc  with(nolock)    
				  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				  where  1=1    
				  and   enc.dr_id  = @dr_id    
				  and   enc.enc_date between @dtstart and @dtend   
				  and enc.issigned = 1 
				  group by enc.patient_id, enc.dr_id,pa_dob   
				 )
				 
				 select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
				 from patient_encounters pe
				 inner join dbo.patients  p  with(nolock) on p.pa_id  = pe.patient_id  
				 where pe.Age>=13
			END	
		IF @MeasureCode='CDS'
			BEGIN
				SELECT p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
				from  dbo.MUMeasureCounts   MUC  with(nolock) 
				left join patients p on p.pa_id=MUC.pa_id    
				where  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.RecordCreateDateTime between @dtstart and @dtend
				and   MUC.IsDenominator = 1
			END
		IF @MeasureCode='DCP'
			BEGIN
				with patient_encounters as    
				(    
				select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @dtstart and @dtend 
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
				and   enc.enc_date between @dtstart and @dtend  
				and	enc.issigned = 1  
				)
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den with(nolock)
				left join patients p on p.pa_id=den.patient_id
			END
		IF @MeasureCode='PTP'
			BEGIN
				with patient_encounters as    
				(    
				select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @dtstart and @dtend  
				and enc.issigned = 1  
				group by enc.patient_id, enc.dr_id    
				),
				Denominator_Data as    
				(    
				select  distinct enc.patient_id   
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @dtstart and @dtend  
				and enc.issigned = 1  
				)
				
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den with(nolock)
				left join patients p on p.pa_id=den.patient_id    
			END	
		IF @MeasureCode='CLS'
			BEGIN
				with patient_encounters as    
				(    
				select            enc.patient_id, enc.enc_id,enc.dr_id, enc.enc_date as last_encounter_date 
				from        dbo.enchanced_encounter       enc         with(nolock)    
				inner join  dbo.patients                        pat         with(nolock)      on      pat.pa_id         =     enc.patient_id    
				where       1=1    
				and               enc.dr_id         =     @dr_id    
				and               enc.enc_date      between     @dtstart and @dtend 
				and		enc.type_of_visit = 'OFICE'   and enc.issigned=1
				),   
				Denominator_Patient as      
				(      
				select  distinct patient_id  As DenomPatient
				from  
				patient_encounters   pe    
				where  1=1      
				)
				,    
				Denominator_Data as    
				(    
				SELECT  pe.patient_id  
				from  patient_encounters   pe  
				inner join  Denominator_Patient dp on pe.patient_id = dp.DenomPatient
				where  1=1    
				)
				
				select den.patient_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den
				left join patients p on p.pa_id=den.patient_id 
			END
		IF @MeasureCode='PEH'
			BEGIN
				SELECT  p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from  dbo.MUMeasureCounts   MUC  with(nolock)
				left join patients p on p.pa_id=MUC.pa_id      
				where  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.RecordCreateDateTime between @dtstart and @dtend
				and   MUC.IsDenominator = 1 
			END
		IF @MeasureCode='CLR'
			BEGIN
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from(select  m.pa_id, m.dr_id,ROW_NUMBER() OVER (PARTITION BY m.id ORDER BY m.id) as pat_rank     
				from  dbo.patient_lab_orders o     
				inner  join dbo.MUMeasureCounts m on o.pa_id = m.pa_id     
				and m.isdenominator=1     
				and o.isactive=1     
				and m.measurecode=@MeasureCode    
				and o.Order_date between @dtstart and @dtend     
				and m.dr_id = @dr_id    
				)as subquery
				left join patients p on p.pa_id=subquery.pa_id       
				where 1=1 and  pat_rank = 1
			END
		IF @MeasureCode='GLP'
			BEGIN
				SELECT p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from  dbo.MUMeasureCounts   MUC  with(nolock)
				left join patients p on p.pa_id=MUC.pa_id      
				where  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.RecordCreateDateTime between @dtstart and @dtend
				and   MUC.IsDenominator = 1 
			END
		IF @MeasureCode='PTR'
			BEGIN
				with patient_encounters as    
				(    
				select  enc.patient_id, enc.dr_id, COUNT(enc.patient_id) as enc_count    
				from  dbo.enchanced_encounter   enc  with(nolock)    
				inner join dbo.patients     pat  with(nolock) on pat.pa_id  = enc.patient_id    
				Left Outer join dbo.patient_extended_details ped  with(nolock) on ped.pa_id  = pat.pa_id  
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between DATEADD(month, -24, @dtstart) and @dtend    
				--and   DATEDIFF(YEAR, pat.pa_dob, enc.enc_date) >= 5    
				and (ped.comm_pref is null or ped.comm_pref <> 255)
				group by enc.patient_id, enc.dr_id    
				having  COUNT(enc.patient_id)  >= 2      
				)
				
				select distinct pe.patient_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart   
				from patient_encounters pe
				left join patients p on p.pa_id=pe.patient_id
			END
		IF @MeasureCode='PAE'
			BEGIN
				with patient_encounters as    
				(    
				select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @dtstart and @dtend  
				and	enc.issigned = 1  
				group by enc.patient_id, enc.dr_id    
				),
				Denominator_Data as    
				(    
				select  distinct enc.patient_id, enc.dr_id    
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @dtstart and @dtend 
				and	enc.issigned = 1   
				group by enc.dr_id,patient_id     
				) 
				
				select patient_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart    
				from Denominator_Data den
				left join patients p on p.pa_id=den.patient_id
			END
		IF @MeasureCode='MDR'
			BEGIN
				with Denominator_Data as    
				(
				select  pat.pa_id   As DenomPatient
					from  dbo.patients    pat    
					inner join dbo.patient_extended_details ped with(nolock) on ped.pa_id  = pat.pa_id 
					inner join	
						(
							select dg_id from doc_groups DG with(nolock) 
							inner join
							(select DG.dc_id dc_id from doctors DR with(nolock)
													inner join doc_groups DG with(nolock) on DR.dg_id = DG.dg_id
													inner join doc_companies DC with(nolock) on DG.dc_id=DC.dc_id
													where DR.dr_id = @dr_id
							)DCS on DG.dc_id = DCS.dc_id
						) DGS on pat.dg_id = DGS.dg_id
					where  1=1    
					and   ped.pa_ext_ref = 1
					and   ped.pa_ref_date  between  @dtstart and @dtend    
					group by pat.pa_id 
				)
				
				select p.pa_id as Patient,
					p.pa_first as FirstName,
					p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,
					p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],
					p.pa_zip as ZipCode,p.pa_ssn as chart 
				from Denominator_Data den
				inner join patients p on p.pa_id=den.DenomPatient
			END
		IF @MeasureCode='SC1'
			BEGIN
				with patient_encounters as      
				(      
				select            enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob      
				from        dbo.enchanced_encounter       enc         with(nolock)      
				inner join  dbo.patients                  pat         with(nolock)      on      pat.pa_id         =     enc.patient_id      
				where       1=1      
				and               enc.dr_id         =     @dr_id      
				and               enc.enc_date      between     @dtstart and @dtend 
				and      enc.issigned = 1
				group by    enc.patient_id, enc.dr_id ,pat.pa_dob  
				),
				Denominator_Patient as      
				(      
				SELECT  distinct pa_id   As DenomPatient   
				from  dbo.MUMeasureCounts   MUC  with(nolock)      
				inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id      
				where  1=1      
				--and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode   
				and   MUC.IsDenominator = 1    
				AND MUC.DateAdded      between     @dtstart and @dtend 
				     
				),
				Denominator_Data as      
				(      
				SELECT  distinct MUC.pa_id      
				from  dbo.MUMeasureCounts   MUC  with(nolock)      
				inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id   
				inner join   Denominator_Patient de ON de.DenomPatient = MUC.pa_id   
				where  1=1      
				and   MUC.MeasureCode    =  @MeasureCode  
				and	  MUC.IsDenominator = 1    
				AND MUC.DateAdded      between     @dtstart and @dtend 
				)
				
				select den.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
				from Denominator_Data den
				left join patients p on p.pa_id=den.pa_id
			END
		IF @MeasureCode='SC2'
			BEGIN
				with patient_encounters as      
				(      
				select            enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob      
				from        dbo.enchanced_encounter       enc         with(nolock)      
				inner join  dbo.patients                        pat         with(nolock)      on      pat.pa_id         =     enc.patient_id      
				where       1=1      
				and               enc.dr_id         =     @dr_id      
				and               enc.enc_date      between     @dtstart and @dtend   
				and		ENC.issigned = 1   
				group by    enc.patient_id, enc.dr_id ,pat.pa_dob  
				),
				Denominator_Patient as      
				(      
				SELECT  distinct pa_id   As DenomPatient   
				from  dbo.MUMeasureCounts   MUC  with(nolock)      
				inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id      
				where  1=1      
				--and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode   
				and   MUC.IsDenominator = 1    
				AND MUC.DateAdded      between     @dtstart and @dtend 
				),
				Denominator_Data as      
				(      
				SELECT  pe.patient_id      
				from  dbo.MUMeasureCounts   MUC  with(nolock)      
				inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id   
				AND MUC.DateAdded      between     @dtstart and @dtend 
				inner join   Denominator_Patient de ON de.DenomPatient = MUC.pa_id   
				where  1=1      
				and   MUC.MeasureCode    =  @MeasureCode 
				and MUC.IsDenominator = 1     
				)
				
				select den.patient_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den
				left join patients p on p.pa_id=den.patient_id
			END
		IF @MeasureCode='SC3'
			BEGIN
				SELECT  p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from  dbo.MUMeasureCounts   MUC  with(nolock)
				left join patients p on p.pa_id=MUC.pa_id    
				where  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.RecordCreateDateTime between @dtstart and @dtend 
				and   MUC.IsDenominator = 1
			END	
		IF @MeasureCode='EIR'
			BEGIN
				SELECT  p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from  dbo.MUMeasureCounts   MUC  with(nolock)
				left join patients p with(nolock) on p.pa_id=MUC.pa_id       
				where  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.RecordCreateDateTime between @dtstart and @dtend 
				and   MUC.IsDenominator = 1
			END
		IF @MeasureCode='SEM'
			BEGIN
				with patient_encounters as    
				(    
				select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @dtstart and @dtend    
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
				)
				
				select patient_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from Denominator_Data den with(nolock)
				left join patients p with(nolock) on p.pa_id=den.patient_id 
			END
		IF @MeasureCode='ESS'
			BEGIN
				SELECT  p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart  
				from  dbo.MUMeasureCounts   MUC  with(nolock)
				left join patients p with(nolock) on p.pa_id=MUC.pa_id     
				where  1=1      
				and   MUC.dr_id     =  @dr_id      
				and   MUC.MeasureCode    =  @MeasureCode      
				and   MUC.RecordCreateDateTime between @dtstart and @dtend 
				and   MUC.IsDenominator = 1
			END
		IF @MeasureCode='ELN'
			BEGIN
				with patient_encounters as  
				(  
				select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date  
				from  dbo.enchanced_encounter  enc  with(nolock)  
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id  
				where  1=1  
				and   enc.dr_id  = @dr_id  
				and   enc.enc_date between @dtstart and @dtend  
				and   enc.type_of_visit = 'OFICE' And enc.issigned = 1 
				group by enc.patient_id, enc.dr_id  
				),
				Denominator_Data as  
				(  
				select  distinct pen.patient_id  
				from  patient_encounters   pen  with(nolock)  
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id  
				where  1=1   
				)  
				select patient_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart   
				from Denominator_Data den with(nolock)
				left join patients p with(nolock) on p.pa_id=den.patient_id 
			END
		IF @MeasureCode='IMG'
			BEGIN
				select p.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
				from patient_lab_orders PLO with(nolock)
				inner join patient_lab_orders_master PLM with(nolock) on PLO.lab_master_id = PLM.lab_master_id
				left join patients p with(nolock) on p.pa_id=PLO.pa_id
				where test_type=1 
				and PLM.dr_id =@dr_id 
				and PLO.added_date between @dtstart and @dtend 
			END
		IF @MeasureCode='FHH'
			BEGIN
				with patient_encounters as    
				(    
				select  distinct enc.patient_id
				from  dbo.enchanced_encounter  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1    
				and   enc.dr_id  = @dr_id    
				and   enc.enc_date between @dtstart and @dtend 
				and enc.issigned = 1   
				),
				Denominator_Data as    
				(    
				select  distinct enc.patient_id   
				from  patient_encounters  enc  with(nolock)    
				inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
				where  1=1     
				)   
				 
				select patient_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart      
				from Denominator_Data den with(nolock)
				left join patients p with(nolock) on p.pa_id=den.patient_id
			END
		IF @MeasureCode='IRS'
			BEGIN
				select  mc.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart         
				from  dbo.MUMeasureCounts mc with(nolock)
				left join patients p with(nolock) on p.pa_id=mc.pa_id   
				where  1=1    
				and mc.dr_id = @dr_id    
				and mc.MeasureCode = @measureCode    
				and mc.DateAdded between @dtstart and @dtend    
				and mc.IsDenominator = 1
			END
		IF @MeasureCode='CD2'
			BEGIN
				select  mc.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart            
				from  dbo.MUMeasureCounts mc with(nolock) 
				left join patients p with(nolock) on p.pa_id=mc.pa_id    
				where  1=1    
				and mc.dr_id = @dr_id    
				and mc.MeasureCode = @measureCode    
				and mc.DateAdded between @dtstart and @dtend    
				and mc.IsDenominator = 1 
			END
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
