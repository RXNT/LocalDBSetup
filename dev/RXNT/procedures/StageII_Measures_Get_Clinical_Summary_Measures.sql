SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[StageII_Measures_Get_Clinical_Summary_Measures]    
@dr_id int, @reporting_start_date date, @reporting_end_date date    
AS    
    
SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10),@MeasureCode Varchar(3);    
 set @MeasureStage = 'MU2014';    
 set @MeasureCode = 'CLS';    
 if exists(select top 1 id from dbo.[MUMeasures] where PassingCriteria = 'Yes/No' and MeasureCode = @MeasureCode)    
  begin    
   select @dr_id As dr_id,@MeasureCode as MeasureCode,0 as Numerator, 0 as Denominator,MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, 'Yes' as MeasureResult,MUM.MeasureGroupName,MUM.Id    
   from dbo.MUMeasures    MUM  with(nolock)    
   where MUM.MeasureCode  = @MeasureCode    
  end    
 else    
  begin    
    with measures_data as    
    (    
    select            @MeasureCode as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id    
    ),    
    patient_encounters as    
    (    
    select            enc.patient_id, enc.enc_id,enc.dr_id, enc.enc_date as last_encounter_date 
    from        dbo.enchanced_encounter       enc         with(nolock)    
    inner join  dbo.patients                        pat         with(nolock)      on      pat.pa_id         =     enc.patient_id    
    where       1=1    
    and               enc.dr_id         =     @dr_id    
    and               enc.enc_date      between     @reporting_start_date and @reporting_end_date 
    and		enc.type_of_visit = 'OFICE'   and enc.issigned=1
    ),    
    Denominator_Patient as      
   (      
    select  distinct patient_id  As DenomPatient
    from  
    patient_encounters   pe    
    where  1=1      
   ) ,
   Numerator_Data as    
   (    
    SELECT  max(@dr_id) As dr_id, count(MUC.pa_id) as Numerator    
    from  dbo.MUMeasureCounts   MUC  with(nolock)    
    inner join patient_encounters   pe  ON  pe.enc_id = MUC.enc_id  
    --inner join  Denominator_Patient dp on pe.patient_id = dp.DenomPatient
    where  1=1    
    --and   MUC.dr_id     =  @dr_id    
    and   MUC.MeasureCode    =  @MeasureCode  
    and  MUC.IsNumerator = 1  
   ),    
   Denominator_Data as    
   (    
    SELECT  max(@dr_id) As dr_id, count(pe.patient_id ) as Denominator    
    from  patient_encounters   pe  
    inner join  Denominator_Patient dp on pe.patient_id = dp.DenomPatient
    where  1=1    
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
  end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
