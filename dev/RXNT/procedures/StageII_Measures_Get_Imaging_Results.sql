SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
    
-- =============================================    
-- Author:  Jignesh Shah    
-- Create date: 01/31/2014    
-- Description: Procedure to get the measures data for imaging results    
-- =============================================    
CREATE PROCEDURE [dbo].[StageII_Measures_Get_Imaging_Results]    
 @dr_id int, @reporting_start_date date, @reporting_end_date date, @measureCode Varchar(3) = 'IMG'    
AS    
BEGIN    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10);    
 set @MeasureStage = 'MU2014';    
    
 with measures_data as    
 (    
  select  @measureCode as MeasureCode, 'MU2014' as MeasureStage, @dr_id as dr_id    
 ),    
 Numerator_Data as    
 (    
  --select  count(mc.pa_id) as Numerator, mc.dr_id    
  --from  dbo.MUMeasureCounts mc with(nolock)    
  --where  1=1    
  --and mc.dr_id = @dr_id    
  --and mc.MeasureCode = @measureCode    
  --and mc.DateAdded between @reporting_start_date and @reporting_end_date    
  --and mc.IsNumerator = 1    
  --group by mc.dr_id
  	select COUNT(*)as Numerator,PLO.dr_id 
	from patient_lab_orders PLO with(nolock)
	inner join patient_lab_orders_master PLM with(nolock) on PLO.lab_master_id = PLM.lab_master_id
	inner join lab_main LBR with(nolock) on PLO.lab_master_id = LBR.lab_order_master_id
	where test_type=1
	and PLM.dr_id =@dr_id
	and PLO.added_date between @reporting_start_date and @reporting_end_date
	group by PLO.dr_id    
 ),    
 Denominator_Data as    
 (    
  --select  count(mc.pa_id) as Denominator, mc.dr_id    
  --from  dbo.MUMeasureCounts mc with(nolock)    
  --where  1=1    
  --and mc.dr_id = @dr_id    
  --and mc.MeasureCode = @measureCode    
  --and mc.DateAdded between @reporting_start_date and @reporting_end_date    
  --and mc.IsDenominator = 1    
  --group by mc.dr_id 
  
    select COUNT(*)as Denominator,PLO.dr_id  
	from patient_lab_orders PLO with(nolock)
	inner join patient_lab_orders_master PLM with(nolock) on PLO.lab_master_id = PLM.lab_master_id
	where test_type=1 
	and PLM.dr_id =@dr_id 
	and PLO.added_date between @reporting_start_date and @reporting_end_date  
	group by PLO.dr_id
     
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
