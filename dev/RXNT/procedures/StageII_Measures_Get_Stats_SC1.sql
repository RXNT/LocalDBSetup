SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--=============================================        
 --Author:  RxNT        
 --Create date: 22/07/2014        
 --Description: Procedure to get the measures data for SC2        
 --=============================================        
CREATE PROCEDURE [dbo].[StageII_Measures_Get_Stats_SC1]        
 @dr_id int, @reporting_start_date date, @reporting_end_date date        
AS        
BEGIN     
  
 -- SET NOCOUNT ON added to prevent extra result sets from        
 -- interfering with SELECT statements.        
 SET NOCOUNT ON;        
 declare @MeasureStage as varchar(10);    
 declare @MeasureCode as varchar(10);      
 set @MeasureStage = 'MU2014';        
 set @MeasureCode = 'SC1';   
         
   with measures_data as      
    (      
    select            @MeasureCode as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id      
      
    ),      
    patient_encounters as      
    (      
    select            enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob      
    from        dbo.enchanced_encounter       enc         with(nolock)      
    inner join  dbo.patients                  pat         with(nolock)      on      pat.pa_id         =     enc.patient_id      
    where       1=1      
    and               enc.dr_id         =     @dr_id      
    and               enc.enc_date      between     @reporting_start_date and @reporting_end_date 
    and      enc.issigned = 1
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
    SELECT  max(@dr_id) As dr_id, count(distinct MUC.pa_id) as Numerator      
    from  dbo.MUMeasureCounts   MUC  with(nolock)      
    inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id  
    inner join   Denominator_Patient de ON de.DenomPatient = MUC.pa_id   
    where  1=1    
    and MUC.MeasureCode    =  @MeasureCode 
    and MUC.IsNumerator = 1    
    AND MUC.DateAdded      between     @reporting_start_date and @reporting_end_date 
    --group by  MUC.dr_id      
   ),      
   Denominator_Data as      
   (      
		SELECT  max(@dr_id) As dr_id, count(distinct MUC.pa_id) as Denominator      
		from  dbo.MUMeasureCounts   MUC  with(nolock)      
		inner join patient_encounters   pe  ON  pe.patient_id = MUC.pa_id   
		inner join   Denominator_Patient de ON de.DenomPatient = MUC.pa_id   
		where  1=1      
		--and   MUC.dr_id     =  @dr_id      
		and   MUC.MeasureCode    =  @MeasureCode  
		and	  MUC.IsDenominator = 1    
		AND MUC.DateAdded      between     @reporting_start_date and @reporting_end_date 
		--group by  MUC.dr_id   
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
