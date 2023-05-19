SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
CREATE PROCEDURE [dbo].[MIPS_Measure_PatientAccess]    
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
  AND	ENC.issigned = 1   
  group by enc.patient_id, enc.dr_id    
 ),    
    
 Numerator_Data as    
 (    
  select  count(distinct pec.patient_id) as Numerator, prd.dr_id    
  from  dbo.patient_reg_db  prd  with(nolock)    
  inner join patient_encounters  pec  with(nolock) on pec.patient_id  = prd.pa_id    
  where  1=1    
  and   prd.dr_id  = @dr_id    
  group by prd.dr_id    
 ),    
    
 Denominator_Data as    
 (    
  select  count(distinct enc.patient_id) as Denominator, enc.dr_id    
  from  dbo.enchanced_encounter  enc  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between @reporting_start_date and @reporting_end_date  
  and	enc.issigned = 1  
  group by enc.dr_id     
 )    
    
 select  VMD.dr_id, MUM.MeasureCode, NUM.Numerator, DEN.Denominator,    
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id, MUM.MeasureClass,  MUM.Performace_points_per_10_percent , MUM.MeasureCalculation   
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MIPSMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
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
