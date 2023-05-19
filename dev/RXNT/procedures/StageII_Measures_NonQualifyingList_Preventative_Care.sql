SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--=============================================        
 --Author:  RxNT        
 --Create date: 28/07/2014        
 --Description: Procedure to get the measures non 
 --				qualifying data for Reminders  
 --				For Preventive Follow Up Care  
 --=============================================        
CREATE PROCEDURE [dbo].[StageII_Measures_NonQualifyingList_Preventative_Care]        
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
    inner join  dbo.patients    pat   with(nolock)      on      pat.pa_id         =     enc.patient_id  
    left join dbo.patient_extended_details ped  with(nolock) on ped.pa_id  = pat.pa_id    
                   and ped.comm_pref <> -1     
    where       1=1      
    and enc.dr_id         =     @dr_id      
    and enc.enc_date between DATEADD(month, -24, @reporting_start_date) and @reporting_start_date 
     --enc.enc_date      between     @reporting_start_date and @reporting_end_date
    ),   
    Denominator_Patient as      
   (      
    select  distinct patient_id   As DenomPatient
    from  patient_encounters        
    --inner join patient_encounters   pe with(nolock) ON  pe.patient_id = MUC.pa_id      
    --where  1=1      
    --and   MUC.dr_id     =  @dr_id      
    --and   MUC.MeasureCode    =  @MeasureCode   
    --and   MUC.IsDenominator = 1    
    --and   MUC.DateAdded      between     @reporting_start_date and @reporting_end_date      
   )  , 
    Numerator_Patient as      
   (      
    SELECT  distinct pa_id   As NumPatient 
    from  dbo.patient_alerts   pta  with(nolock)
    inner join patient_encounters   pe with(nolock)  ON  pe.patient_id = pta.pa_id
	inner join Denominator_Patient  dp  with(nolock) ON  pe.patient_id = dp.DenomPatient
    where  1=1    and  pta.dt_performed between @reporting_start_date and @reporting_end_date
    --and   MUC.dr_id     =  @dr_id      
    --and   MUC.MeasureCode    =  @MeasureCode   
    --and   MUC.IsNumerator = 1    
    --and	  MUC.DateAdded      between     @reporting_start_date and @reporting_end_date  
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
