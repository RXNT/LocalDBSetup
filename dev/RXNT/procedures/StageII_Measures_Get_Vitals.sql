SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Sandeep Kesarkar    
-- Create date: 01/13/2014    
-- Description: Procedure to get the measures data for Vitals    
-- =============================================    
CREATE PROCEDURE [dbo].[StageII_Measures_Get_Vitals]    
 @dr_id int, @reporting_start_date date, @reporting_end_date date, @exclusion int =0    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10), @MeasureCode Varchar(3);    
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
            SELECT @dr_id dr_id, count(distinct Numerator)  as Numerator FROM (    
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
  select SUM(    
     case @exclusion          
      when 2 then    
       case     
        when DATEDIFF(YEAR, pa_dob, last_encounter_date) >= 2 then 1    
        else 0     
       end    
      else 1    
     end    
    ) as Denominator, dr_id      
  from patient_encounters    
  group by dr_id    
 )    
    
 select  VMD.dr_id, MUM.MeasureCode, NUM.Numerator, DEN.Denominator,    
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id  
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MUMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
                 and MUM.MeasureCode  = @MeasureCode    
                 and MUM.IsActive  = 1    
                 and MUM.MeasureStage = @MeasureStage    
 left join Numerator_Data    NUM  with(nolock) on NUM.dr_id   = VMD.dr_id    
 left join Denominator_Data   DEN  with(nolock) on DEN.dr_id   = VMD.dr_id    
     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
