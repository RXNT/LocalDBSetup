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
CREATE PROCEDURE [dbo].[MIPS_MISSING_PATIENT_VDT]        
 @dr_id int, 
 @reporting_start_date date,
 @reporting_end_date date ,
 @measureCode varchar(10)       
AS        
BEGIN
	SET NOCOUNT ON;        
	
	with measures_data as      
    (      
    select            @MeasureCode as MeasureCode, @dr_id as dr_id      
      
    ),      
    patient_encounters as      
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
    Denominator_Patient as      
   ( 
		   select  distinct pen.patient_id as DenomPatient,     
			 pen.dr_id     
		  from  patient_encounters   pen  with(nolock)    
		  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id    
		  where  1=1     

   )  , 
    Numerator_Patient as      
   (      
		select  distinct pen.patient_id as NumPatient,     
		pen.dr_id     
	  from  patient_encounters   pen  with(nolock)    
	  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id   
	  inner join dbo.patient_login pl with(nolock) on pl.pa_id = pen.patient_id
	  where  1=1     
	  group by pen.patient_id, pen.dr_id
  
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
