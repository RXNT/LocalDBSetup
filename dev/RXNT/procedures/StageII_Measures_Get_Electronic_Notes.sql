SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
-- =============================================  
-- Author:  Jignesh Shah  
-- Create date: 01/31/2014  
-- Description: Procedure to get the measures data for electronic notes  
-- =============================================  
CREATE PROCEDURE [dbo].[StageII_Measures_Get_Electronic_Notes]  
 @dr_id int, @reporting_start_date date, @reporting_end_date date, @measureCode Varchar(3) = 'ELN'  
AS  
BEGIN  
 SET NOCOUNT ON;  
 declare @MeasureStage as varchar(10);  
 set @MeasureStage = 'MU2014';  
  
 with measures_data as  
 (  
  select  @measureCode as MeasureCode, 'MU2014' as MeasureStage, @dr_id as dr_id  
 ),  
 patient_encounters as  
 (  
  select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date  
  from  dbo.enchanced_encounter  enc  with(nolock)  
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id  
  where  1=1  
  and   enc.dr_id  = @dr_id  
  and   enc.enc_date between @reporting_start_date and @reporting_end_date  
  and   enc.type_of_visit = 'OFICE' And enc.issigned = 1 
  group by enc.patient_id, enc.dr_id  
 ),  
 Numerator_Data as  
 (  
  select  Count(distinct pen.patient_id) as Numerator,   
     pen.dr_id   
  from  patient_encounters   pen  with(nolock)  
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id  
  where  1=1   
  group by pen.dr_id  
 ),  
 Denominator_Data as  
 (  
  select  Count(distinct pen.patient_id) as Denominator,   
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
