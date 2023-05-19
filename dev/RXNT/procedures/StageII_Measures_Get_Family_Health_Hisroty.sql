SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
-- =============================================    
-- Author:  Jignesh Shah    
-- Create date: 02/03/2014    
-- Description: Procedure to get the measures data for Family_Health_Hisroty    
-- =============================================    
CREATE PROCEDURE [dbo].[StageII_Measures_Get_Family_Health_Hisroty]    
 @dr_id int, @reporting_start_date date, @reporting_end_date date, @measureCode Varchar(3)    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10)    
 set @MeasureStage = 'MU2014';    
    
 with measures_data as    
 (    
  select  @measureCode as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id    
 ),    
 patient_encounters as    
 (    
  select  distinct enc.patient_id
  -- , enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
  from  dbo.enchanced_encounter  enc  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between @reporting_start_date and @reporting_end_date 
  and enc.issigned = 1   
   --group by enc.patient_id, enc.dr_id    
 ),    
    
 Numerator_Data as    
 (    
  --select  count(_log.pa_id) as Numerator, pec.dr_id    
  -- select  count(distinct pat_id) as Numerator, hx.dr_id 
  select  count(distinct pat_id) as Numerator, max(@dr_id) as dr_id  
  from  patient_family_hx hx with(nolock)    
  inner join  patient_encounters enc with(nolock) on enc.patient_id = hx.pat_id    
  -- where  1=1    
  --and hx.created_on between @reporting_start_date and @reporting_end_date    
  -- and hx.dr_id = @dr_id    
  -- group by hx.dr_id    
 ),    
    
 Denominator_Data as    
 (    
  select  count(distinct enc.patient_id) as Denominator, max(@dr_id) as dr_id    
  from  patient_encounters  enc  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1     
  --and   enc.last_encounter_date between @reporting_start_date and @reporting_end_date    
  --group by enc.dr_id     
 )    
     
 select  VMD.dr_id, MUM.MeasureCode, NUM.Numerator, DEN.Denominator,    
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id  
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MUMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
                 and MUM.MeasureCode  = @measureCode    
                 and MUM.IsActive  = 1    
                 and MUM.MeasureStage = @MeasureStage    
 left join Numerator_Data    NUM  with(nolock) on VMD.dr_id = NUM.dr_id
 left join Denominator_Data   DEN  with(nolock) on VMD.dr_id  = DEN.dr_id  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
