SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 --=============================================        
 --Author:  RxNT        
 --Create date: 25/07/2014        
 --Description: Procedure to get the measures non 
 --				qualifying data for View Download 
 --				Transmit Patient     
 --=============================================        
CREATE PROCEDURE [dbo].[StageII_Measures_NonQualifyingList_View_Download_Transmit_Patient]        
 @dr_id int, 
 @reporting_start_date date,
 @reporting_end_date date ,
 @measureCode varchar(10)       
AS        
BEGIN
	SET NOCOUNT ON;        
	 declare @MeasureStage as varchar(10)    
 set @MeasureStage = 'MU2014'; 
 
	with measures_data as    
 (    
  select  @measureCode as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id    
 ),    
 patient_encounters as    
 (    
  select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
  from  dbo.enchanced_encounter  enc  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between @reporting_start_date and @reporting_end_date  
  and enc.issigned = 1  
  group by enc.patient_id, enc.dr_id    
 ),    
    
 Numerator_Patient as    
 (    
	select DISTINCT pa_id As NumPatient 
	from(
		  select  distinct _log.pa_id as pa_id, pec.dr_id    
		  from  dbo.patient_phr_access_log _log with(nolock)    
		  inner join patient_encounters  pec  with(nolock) on pec.patient_id  = _log.pa_id    
			--and _log.phr_access_datetime between @reporting_start_date and @reporting_end_date    
			UNION
  
		   select  distinct _reg_db.pa_id as pa_id, pec.dr_id    
		   from  dbo.patient_reg_db _reg_db with(nolock)    
		   inner join patient_encounters  pec  with(nolock) on pec.patient_id  = _reg_db.pa_id
		   WHERE _reg_db.opt_out=1    
                 --and _log.phr_access_datetime between @reporting_start_date and @reporting_end_date    
  
  
 ) res
 ),    
    
 Denominator_Patient as    
 (    
  select  distinct enc.patient_id as DenomPatient 
  from  dbo.enchanced_encounter  enc  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between @reporting_start_date and @reporting_end_date  
  and enc.issigned = 1  
 )    
     
 
	select pa_id as Patient,pa_first as FirstName,pa_last as LastName,pat.pa_dob as DateOfBirth,pa_sex as sex,
   pa_address1 as Address1,pa_city as City,pa_state as [State],pa_zip as ZipCode,pa_ssn as chart
   from  dbo.Patients    PAT  with(nolock)      
   inner join Denominator_Patient   DEN  with(nolock) on DEN.DenomPatient   = PAT.pa_id    
   left join Numerator_Patient    NUM  with(nolock) on DEN.DenomPatient = NUM.NumPatient
   where NUM.NumPatient is null 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
