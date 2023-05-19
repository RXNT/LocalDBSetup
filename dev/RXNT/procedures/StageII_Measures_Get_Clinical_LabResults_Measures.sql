SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
CREATE PROCEDURE [dbo].[StageII_Measures_Get_Clinical_LabResults_Measures]    
 @dr_id int, @reporting_start_date date, @reporting_end_date date    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10), @MeasureCode Varchar(3);    
 set @MeasureStage = 'MU2014';    
 set @MeasureCode = 'CLR';    
    
 with measures_data as    
 (    
  select  @MeasureCode as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id    
 ),    
 Numerator_Data as    
 (    
  select  count(mc.pa_id) as Numerator, mc.dr_id    
  from  dbo.MUMeasureCounts mc with(nolock)    
  where  1=1    
  and mc.dr_id = @dr_id    
  and mc.MeasureCode = @measureCode    
  and mc.DateAdded between @reporting_start_date and @reporting_end_date    
  and mc.IsNumerator = 1    
  group by mc.dr_id    
 ),    
 Denominator_Data as    
 (       
  select  dr_id, count(pa_id) as denominator from(    
   select  m.pa_id, m.dr_id,ROW_NUMBER() OVER (PARTITION BY m.id ORDER BY m.id) as pat_rank     
   from  dbo.patient_lab_orders o     
   inner  join dbo.MUMeasureCounts m on o.pa_id = m.pa_id     
   and m.isdenominator=1     
   and o.isactive=1     
   and m.measurecode=@MeasureCode    
   and o.Order_date between @reporting_start_date     
   and @reporting_end_date     
   and m.dr_id = @dr_id    
  )as subquery    
  where 1=1 and  pat_rank = 1    
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
