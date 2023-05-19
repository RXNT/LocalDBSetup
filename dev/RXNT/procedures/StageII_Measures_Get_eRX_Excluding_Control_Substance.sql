SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Sandeep Kesarkar    
-- Create date: 04/21/2014    
-- Description: Procedure to get the measures data for eRX excluding control substance.    
-- =============================================    
CREATE PROCEDURE [dbo].[StageII_Measures_Get_eRX_Excluding_Control_Substance]    
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
    
 Denominator_Data as    
 (    
  select  count(prx.pres_id) as Denominator, prx.dr_id    
  from  dbo.prescriptions   prx with(nolock)    
  inner join dbo.prescription_details pxd with(nolock) on pxd.pres_id  = prx.pres_id    
  inner join dbo.RMIID1     rd1 with(nolock)  on rd1.medid  = pxd.ddid    
  where  1=1    
  and   prx.dr_id     = @dr_id    
  and   prx.pres_entry_date   between  @reporting_start_date and @reporting_end_date    
  and   prx.pres_void    = 0 
  and	prx.pres_approved_date is not null   
  and   rd1.MED_REF_DEA_CD   < 2
  group by prx.dr_id    
 ),    
    
 Numerator_Data as    
 (    
  select  count(prx.pres_id) as Numerator, prx.dr_id    
  from  dbo.prescriptions   prx with(nolock)    
  inner join dbo.prescription_details pxd with(nolock)  on pxd.pres_id  = prx.pres_id    
  --inner join dbo.prescription_coverage_info pci with(nolock) on pci.pd_id  = pxd.pd_id    
  inner join dbo.RMIID1     rd1 with(nolock)  on rd1.medid  = pxd.ddid      
  where  1=1    
  and   prx.dr_id     = @dr_id    
  and   prx.pres_entry_date   between  @reporting_start_date and @reporting_end_date    
  and   prx.pres_void    = 0    
  and	prx.pres_approved_date is not null   
  and   prx.pres_delivery_method > 2    
  and   rd1.MED_REF_DEA_CD   < 2
  group by prx.dr_id    
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
