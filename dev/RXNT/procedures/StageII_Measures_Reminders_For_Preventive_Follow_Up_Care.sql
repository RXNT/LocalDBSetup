SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Sandeep Kesarkar    
-- Create date: 01/28/2014    
-- Description: Procedure to get the measures data for Reminders_For_Preventive_Follow_Up_Care    
-- =============================================    
CREATE PROCEDURE [dbo].[StageII_Measures_Reminders_For_Preventive_Follow_Up_Care]    
 @dr_id int, @reporting_start_date date, @reporting_end_date date, @measureCode Varchar(3)    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10);    
 set @MeasureStage = 'MU2014';    
    
 with measures_data as    
 (    
  select  'PTR' as MeasureCode, 'MU2014' as MeasureStage, @dr_id as dr_id    
 ),    
 patient_encounters as    
 (    
  select  enc.patient_id, enc.dr_id, COUNT(enc.patient_id) as enc_count    
  from  dbo.enchanced_encounter   enc  with(nolock)    
  inner join dbo.patients     pat  with(nolock) on pat.pa_id  = enc.patient_id    
  left join dbo.patient_extended_details ped  with(nolock) on ped.pa_id  = pat.pa_id    
                   and ped.comm_pref <> -1    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between DATEADD(month, -24, @reporting_start_date) and @reporting_start_date    
  --and   DATEDIFF(YEAR, pat.pa_dob, enc.enc_date) >= 5    
  group by enc.patient_id, enc.dr_id    
  having  COUNT(enc.patient_id)  >= 2    
 ),    
    
 Numerator_Data as    
 (    
  select  count(distinct pec.patient_id) as Numerator, pec.dr_id    
  from  dbo.patient_alerts  pta  with(nolock)    
  inner join patient_encounters  pec  with(nolock) on pec.patient_id  = pta.pa_id    
  where  1=1    
  and   pec.dr_id  = @dr_id and pta.dt_performed between @reporting_start_date and @reporting_end_date
  group by pec.dr_id    
 ),    
    
 Denominator_Data as    
 (    
  select  count(distinct pte.patient_id) as Denominator, pte.dr_id    
  from  patient_encounters   pte  with(nolock)    
  where  1=1     
  group by pte.dr_id    
 )    
    
 select  VMD.dr_id, MUM.MeasureCode, NUM.Numerator, DEN.Denominator,    
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id    
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MUMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
                 and MUM.MeasureCode  = @measureCode    
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
