SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  RxNT   
-- Create date: 09/13/2017    
-- Description: Procedure to get the measures data for View_Download_Transmit_Patient    
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_Measure_RequestAndReceiveSOC]
 @dr_id int,@dg_id int = null, @reporting_start_date date, @reporting_end_date date, @measureCode Varchar(3)    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10)    
 set @MeasureStage = 'MIPS2017';    
    
    
 with measures_data as    
 (    
  select  @measureCode as MeasureCode, 'MIPS2017' as MeasureStage, @dr_id as dr_id    
 ),    
 patient_encounters as    
 (    
  select  enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date    
  from  dbo.enchanced_encounter  enc  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id    
  where  1=1    
  and   enc.dr_id  = @dr_id    
  and   enc.enc_date between @reporting_start_date and @reporting_end_date    
  and   enc.type_of_visit = 'OFICE'    
  and	enc.issigned = 1
  group by enc.patient_id, enc.dr_id    
 ),    
 Numerator_Data as    
 (    
   select  count(distinct doc.pat_id) as Numerator, pat.dr_id    
  from  [dbo].[patient_documents] doc with(nolock)    
  inner join patients  pat  with(nolock) on pat.pa_id = doc.pat_id    
  where   ((@dg_id IS NULL and pat.dr_id = @dr_id) OR
  (@dg_id IS NOT NULL AND pat.dg_id=@dg_id))  AND doc.cat_id = 6  
  group by pat.dr_id       
 ),    
 Denominator_Data as    
 (    
  Select   Count(distinct refered.pa_id) as Denominator,   refered.dr_id     
  from  dbo.[patient_extended_details]   refered  with(nolock)    
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = refered.pa_id    
  where  ((@dg_id IS NULL and pat.dr_id = @dr_id) OR
  (@dg_id IS NOT NULL AND pat.dg_id=@dg_id))  AND  refered.pa_ext_ref = 1 
   AND cast (refered.pa_ref_date as date) BETWEEN @reporting_start_date and @reporting_end_date    
  AND refered.pa_ref_name_details  IS NOT NULL  
  group by refered.dr_id 
 )      
     
 select  VMD.dr_id, MUM.MeasureCode, 
		case when NUM.Numerator > DEN.Denominator THEN DEN.Denominator ELSE NUM.Numerator END Numerator, 
		DEN.Denominator,    
		MUM.MeasureName, 
		MUM.DisplayOrder, 
		MUM.MeasureDescription, 
		MUM.PassingCriteria, 
		MUm.MeasureGroup, 
		MUM.MeasureStage, 
		null as MeasureResult,
		MUM.MeasureGroupName,
		MUM.Id,
		MUM.MeasureClass,  
		MUM.Performace_points_per_10_percent,
		MUM.MeasureCalculation   
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
