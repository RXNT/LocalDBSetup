SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
   

-- =============================================    
-- Author:  Jignesh Shah    
-- Create date: 01/29/2014    
-- Description: Procedure to get the measures data for View_Download_Transmit_Patient    
-- =============================================    
CREATE PROCEDURE [dbo].[StageII_Measures_Get_Medical_Reconciliation]    
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
Denominator_Patient as      
(
	select  pat.pa_id   As DenomPatient
		from  dbo.patients    pat    
		inner join dbo.patient_extended_details ped with(nolock) on ped.pa_id  = pat.pa_id 
		inner join	
			(
				select dg_id from doc_groups DG with(nolock) 
							inner join
							(select DG.dc_id dc_id from doctors DR with(nolock)
													inner join doc_groups DG with(nolock) on DR.dg_id = DG.dg_id
													inner join doc_companies DC with(nolock) on DG.dc_id=DC.dc_id
													where DR.dr_id = @dr_id
							)DCS on DG.dc_id = DCS.dc_id
			) DGS on pat.dg_id = DGS.dg_id
		where  1=1    
		and   ped.pa_ext_ref = 1
		and   ped.pa_ref_date  between @reporting_start_date and @reporting_end_date    
		group by pat.pa_id   
    
) , 
Numerator_Patient as    
 ( 	  
	  SELECT  MUC.pa_id   As NumeratorPatient
		from  dbo.MUMeasureCounts MUC    with(nolock)
		inner join Denominator_Patient  dp  with(nolock) ON  MUC.pa_id = dp.DenomPatient
		where  1=1    
		and   MUC.MeasureCode    =  @MeasureCode   
		and   MUC.IsNumerator = 1   
		and	  MUC.DateAdded      < @reporting_end_date 
		group by MUC.pa_id
 ),
 Numerator_Data as    
 (
 	select  count(NumeratorPatient) as Numerator,  max(@dr_id) dr_id   
	  from  Numerator_Patient
 ),    
    
 Denominator_Data as    
 (    
	  select  count(DenomPatient) as Denominator,  max(@dr_id) dr_id   
	  from  Denominator_Patient
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
		MUM.Id  
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
