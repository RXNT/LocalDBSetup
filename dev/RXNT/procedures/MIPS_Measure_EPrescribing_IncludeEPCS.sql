SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
CREATE PROCEDURE [dbo].[MIPS_Measure_EPrescribing_IncludeEPCS]    
 @dr_id int, @reporting_start_date date, @reporting_end_date date    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10), @MeasureCode Varchar(3);    
 set @MeasureStage = 'MIPS2017';    
 set @MeasureCode = 'EPI';    
    
 with measures_data as    
 (    
  select  @MeasureCode as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id    
 ),    
 Numerator_Data as    
 (
  select p.dr_id,  count(p.pres_id) as Numerator 
  from prescriptions p 
  inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
  inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
  where 
  p.dr_id = @dr_id and 
  p.pres_delivery_method > 2 and
  p.pres_void = 0 and
  p.pres_approved_date between @reporting_start_date and @reporting_end_date
  group by p.dr_id 
 ),    
 Denominator_Data as    
 ( 
  
	select count(p.pres_id) as Denominator, p.dr_id  
  from prescriptions p 
  inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
  where 
  p.dr_id = @dr_id and
  p.pres_void = 0 and
  p.pres_approved_date between @reporting_start_date and @reporting_end_date 
  group by p.dr_id  
 )    
    
 select  VMD.dr_id, MUM.MeasureCode, NUM.Numerator, DEN.Denominator,    
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id, MUM.MeasureClass,  MUM.Performace_points_per_10_percent, MUM.MeasureCalculation
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MIPSMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
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
