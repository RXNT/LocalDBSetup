SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
CREATE PROCEDURE [dbo].[MIPS_Measure_HIE]   
 @dr_id int, @reporting_start_date date, @reporting_end_date date, @measureCode Varchar(3)   
AS    
BEGIN    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10);      
   
 set @MeasureStage = 'MIPS2017';    
 set @MeasureCode = 'SC2';  
        
   with measures_data as      
    (      
    select            'HIE' as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id      
      
    ),      
    patient_encounters as      
    (      
    select            enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob      
    from        dbo.enchanced_encounter       enc         with(nolock)      
    inner join  dbo.patients                        pat        
	 with(nolock)      on      pat.pa_id         =     enc.patient_id      
    where       1=1      
    and               enc.dr_id         =     @dr_id      
    and               enc.enc_date      between     @reporting_start_date and @reporting_end_date   
    and		ENC.issigned = 1   
    group by    enc.patient_id, enc.dr_id ,pat.pa_dob  
    ),   
    Denominator_Patient as      
   (      
    SELECT  distinct pa_id   As DenomPatient   
    from  dbo.MUMeasureCounts   MUC  with(nolock)      
    inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id      
    where  1=1      
    --and   MUC.dr_id     =  @dr_id      
    and   MUC.MeasureCode    =  @MeasureCode   
    and   MUC.IsDenominator = 1    
    AND MUC.DateAdded      between     @reporting_start_date and @reporting_end_date 
         
   )  ,  
   Numerator_Data as      
   (      
    SELECT  max(@dr_id) As dr_id, sum(case when MUC.IsNumerator = 1 then 1 else 0 end) as Numerator      
    from  dbo.MUMeasureCounts   MUC  with(nolock)      
    inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id   
    AND MUC.DateAdded      between     @reporting_start_date and @reporting_end_date 
    inner join   Denominator_Patient de ON de.DenomPatient = MUC.pa_id   
    where  1=1          
    and   MUC.MeasureCode    =  @MeasureCode      
    --group by  MUC.dr_id      
   ),      
   Denominator_Data as      
   (      
     SELECT  max(@dr_id) As dr_id, sum(case when MUC.IsDenominator = 1 then 1 else 0 end) as Denominator      
    from  dbo.MUMeasureCounts   MUC  with(nolock)      
    inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id   
    AND MUC.DateAdded      between     @reporting_start_date and @reporting_end_date 
    inner join   Denominator_Patient de ON de.DenomPatient = MUC.pa_id   
    where  1=1      
    --and   MUC.dr_id     =  @dr_id      
    and   MUC.MeasureCode    =  @MeasureCode      
    --group by  MUC.dr_id     
   )     
       
	   
	 select  VMD.dr_id, MUM.MeasureCode,CASE WHEN NUM.Numerator>DEN.Denominator THEN DEN.Denominator ELSE  NUM.Numerator END Numerator, DEN.Denominator,    
		 MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUM.MeasureGroup,				MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id , MUM.MeasureClass,						MUM.Performace_points_per_10_percent , MUM.MeasureCalculation
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MIPSMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
                 and MUM.MeasureCode  = 'HIE'    
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
