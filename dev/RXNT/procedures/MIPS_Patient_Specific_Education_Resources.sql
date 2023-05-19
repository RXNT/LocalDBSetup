SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 --=============================================        
 --Author:  RxNT        
 --Create date: 13/09/2017        
 --Description: Procedure to get the measures non 
 --				qualifying data for View Download 
 --				Transmit Doctor     
 --=============================================        
CREATE PROCEDURE [dbo].[MIPS_Patient_Specific_Education_Resources]    
 @dr_id int, @reporting_start_date date, @reporting_end_date date, @measureCode Varchar(3)    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10)    
 set @MeasureStage = 'MIPS2017';    
    
 with measures_data as    
 (    
  select  @measureCode as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id    
 ),    
 patient_encounters as    
 (    
  select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
  from  dbo.enchanced_encounter  enc  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between @reporting_start_date and @reporting_end_date  
  and	enc.issigned = 1  
  group by enc.patient_id, enc.dr_id    
 ),    
    
 Numerator_Data as    
 (    
  select  count(distinct enc.patient_id) as Numerator, max(@dr_id) doctor_id    
  from  dbo.MUMeasureCounts mc with(nolock)    
  inner join patient_encounters  enc  with(nolock) on enc.patient_id = mc.pa_id    
  where  1=1    
  --and mc.dr_id = @dr_id    
  and mc.MeasureCode = @measureCode 
  and   mc.IsNumerator = 1   
  and mc.DateAdded between @reporting_start_date and @reporting_end_date    
  group by enc.dr_id    
 ),    
    
 Denominator_Data as    
 (    
  select  count(distinct enc.patient_id) as Denominator, enc.dr_id    
  from  dbo.enchanced_encounter  enc  with(nolock)    
  inner join dbo.patients  pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between @reporting_start_date and @reporting_end_date 
  and	enc.issigned = 1   
  group by enc.dr_id     
 )    
     
 select  VMD.dr_id, MUM.MeasureCode, NUM.Numerator, DEN.Denominator,    
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id , MUM.MeasureClass,  MUM.Performace_points_per_10_percent , MUM.MeasureCalculation
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MIPSMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
                 and MUM.MeasureCode  = @measureCode    
                 and MUM.IsActive  = 1    
                 and MUM.MeasureStage = @MeasureStage    
 left join Numerator_Data    NUM  with(nolock) on NUM.doctor_id   = VMD.dr_id    
 left join Denominator_Data   DEN  with(nolock) on DEN.dr_id   = VMD.dr_id    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
