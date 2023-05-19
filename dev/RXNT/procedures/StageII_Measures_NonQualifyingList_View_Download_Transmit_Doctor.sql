SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 --=============================================        
 --Author:  RxNT        
 --Create date: 25/07/2014        
 --Description: Procedure to get the measures non 
 --				qualifying data for View Download 
 --				Transmit Doctor     
 --=============================================        
CREATE PROCEDURE [dbo].[StageII_Measures_NonQualifyingList_View_Download_Transmit_Doctor]        
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
    select           distinct enc.patient_id
    from        dbo.enchanced_encounter       enc         with(nolock)      
    inner join  dbo.patients                        pat         with(nolock)      on      pat.pa_id         =     enc.patient_id      
    where       1=1      
    and               enc.dr_id         =     @dr_id      
    and               enc.enc_date      between     @reporting_start_date and @reporting_end_date
    and		enc.issigned = 1
    ),   
    Denominator_Patient as      
   (      
	select  distinct enc.patient_id as DenomPatient, enc.dr_id    
	from  dbo.enchanced_encounter  enc  with(nolock)    
	inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
	where  1=1    
	and   enc.dr_id  = @dr_id    
	and   enc.enc_date between @reporting_start_date and @reporting_end_date  
	and	enc.issigned = 1       
   )  , 
    Numerator_Patient as      
   (      
	SELECT  distinct pe.patient_id   As NumPatient 
	from  dbo.patient_reg_db   prd  with(nolock)     
	inner join patient_encounters   pe with(nolock)  ON  pe.patient_id = prd.pa_id
	inner join Denominator_Patient  dp  with(nolock) ON  pe.patient_id = dp.DenomPatient
	where  1=1 and 
	prd.dr_id  = @dr_id 
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
