SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Sandeep Kesarkar    
-- Create date: 01/13/2014    
-- Description: Procedure to get the measures data for SmokingStatus    
-- =============================================    
CREATE PROCEDURE [dbo].[StageII_Measures_Get_SmokingStatus]    
 @dr_id int, @reporting_start_date date, @reporting_end_date date    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10), @MeasureCode Varchar(3);    
 set @MeasureStage = 'MU2014';    
 set @MeasureCode = 'SMK';    
    
 with measures_data as    
 (    
  select  'SMK' as MeasureCode, 'MU2014' as MeasureStage, @dr_id as dr_id    
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
     
 patient_flag_data as    
 (    
  select  pat.pa_id    
  from  patient_encounters   pen  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id    
  inner join dbo.patient_flag_details pfd  with(nolock) on pfd.pa_id  = pen.patient_id    
  where  1=1    
  and   pfd.flag_id     in  (-1,-2,-3,-4,-5,5,6,7)    
  group by pat.pa_id    
 ),    
     
 Numerator_Data as    
 (    
  select  COUNT(pat.pa_id) as Numerator,    
     pen.dr_id    
  from  patient_encounters    pen   with(nolock)    
  inner join dbo.patients     pat   with(nolock)  on pat.pa_id  = pen.patient_id    
  inner join patient_flag_data    pfd   with(nolock)  on pfd.pa_id  = pen.patient_id    
  where  1=1    
  and   DATEDIFF(YEAR, pat.pa_dob, pen.last_encounter_date) >= 13    
  group by pen.dr_id    
 ),     
    
 Denominator_Data as    
 (    
  select  SUM(case when DATEDIFF(YEAR, pat.pa_dob, pen.last_encounter_date) >= 13    
       then 1    
       else 0    
      end) as Denominator,     
     pen.dr_id     
  from  patient_encounters   pen  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id    
  where  1=1     
  group by pen.dr_id    
 )    
    
 select  VMD.dr_id, MUM.MeasureCode, NUM.Numerator, DEN.Denominator,    
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id    
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MUMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
                 and MUM.MeasureCode  = @MeasureCode    
                 and MUM.IsActive  = 1    
                 and MUM.MeasureStage = @MeasureStage    
 left join Numerator_Data    NUM  with(nolock) on NUM.dr_id   = VMD.dr_id    
 left join Denominator_Data   DEN  with(nolock) on NUM.dr_id   = VMD.dr_id    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
