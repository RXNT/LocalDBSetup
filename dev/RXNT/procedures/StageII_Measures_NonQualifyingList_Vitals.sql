SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 --=============================================        
 --Author:  RxNT        
 --Create date: 28/07/2014        
 --Description: Procedure to get the measures non 
 --				qualifying data for Vitals    
 --=============================================        
CREATE PROCEDURE [dbo].[StageII_Measures_NonQualifyingList_Vitals]        
 @dr_id int, 
 @reporting_start_date date,
 @reporting_end_date date ,
 @measureCode varchar(10) ,    
 @exclusion int =0  
AS        
BEGIN
	 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10);    
 set @MeasureStage = 'MU2014';    
 set @MeasureCode = 'VTL';    
    
 with measures_data as    
 (    
  select  'VTL' as MeasureCode, 'MU2014' as MeasureStage, @dr_id as dr_id    
 ),    
 patient_encounters as    
 (    
  select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob    
  from  dbo.enchanced_encounter  enc  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between @reporting_start_date and @reporting_end_date 
  and enc.issigned = 1   
  group by enc.patient_id, enc.dr_id, pat.pa_dob    
 ),    
    
 Numerator_Data as    
      (    
            SELECT distinct Numerator as Numerator  FROM (    
            select                
                              case @exclusion                                     
                                    when 2 then --Any EP who believes that blood pressure is relevant to their scope of practice, but height/length and weight are not, is excluded from recording height/length and weight.      
                                          case     
                                                when ISNULL(ptv.pa_bp_sys,0)>0 AND DATEDIFF(YEAR, pa_dob, last_encounter_date) >= 2  then     ptv.pa_id 
                                                else 0          
                                          end       
                                    when 1 then     
                                                      --Any EP who believes that height/length and weight are relevant to their scope of practice, but blood pressure is not, is excluded from recording blood pressure.      
                                          case     
                                                when ptv.pa_ht > 0 AND ptv.pa_wt > 0 AND (ptv.pa_bp_sys IS NULL OR ptv.pa_bp_sys = 0) then  ptv.pa_id  
                                                when ptv.pa_ht > 0 AND ptv.pa_wt > 0 AND ptv.pa_bp_sys > 0 then  ptv.pa_id     
                                                else 0          
                                          end      
                                    else                              
                                          case     
                                                when (ptv.pa_ht > 0 AND ptv.pa_wt > 0 AND ptv.pa_bp_sys > 0)then  ptv.pa_id 
                                                when (ptv.pa_ht > 0 AND ptv.pa_wt > 0) AND (ptv.pa_bp_sys IS NULL OR ptv.pa_bp_sys = 0) AND  DATEDIFF(YEAR, pen.pa_dob, pen.last_encounter_date) < 3 then  ptv.pa_id     
                                                else 0          
                                          end       
                              end   as Numerator,                                    
                              pen.patient_id   
            from        patient_encounters                        pen               with(nolock)    
            inner join  dbo.patient_vitals                        ptv           with(nolock)            on    ptv.pa_id         =     pen.patient_id 
            --where       1=1             
            ) as subQuery    
            where 1=1      
            and Numerator > 0      
      )    
 ,    
    
 Denominator_Data as    
 (       
  select  distinct   
     case @exclusion          
      when 2 then    
       case     
        when DATEDIFF(YEAR, pa_dob, last_encounter_date) >= 2 then patient_id    
        else 0     
       end    
      else patient_id    
     end    
     as Denominator    
  from patient_encounters    
 )    
    
 select pa_id as Patient,pa_first as FirstName,pa_last as LastName,pat.pa_dob as DateOfBirth,pa_sex as sex,
   pa_address1 as Address1,pa_city as City,pa_state as [State],pa_zip as ZipCode,pa_ssn as chart
   from  dbo.Patients    PAT  with(nolock)      
   inner join Denominator_Data   DEN  with(nolock) on DEN.Denominator   = PAT.pa_id    
   left join Numerator_Data    NUM  with(nolock) on DEN.Denominator = NUM.Numerator
   where NUM.Numerator is null  
     

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
