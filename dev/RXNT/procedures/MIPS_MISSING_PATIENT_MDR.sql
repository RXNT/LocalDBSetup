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
CREATE PROCEDURE [dbo].[MIPS_MISSING_PATIENT_MDR]        
 @dr_id int, 
 @reporting_start_date date,
 @reporting_end_date date ,
 @measureCode varchar(10)       
AS        
BEGIN
	SET NOCOUNT ON;        
	
	with measures_data as      
    (      
    select            @MeasureCode as MeasureCode, @dr_id as dr_id      
      
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
   ), 
    Numerator_Patient as      
   (      
		SELECT  MUC.pa_id   As NumPatient
		from  dbo.MUMeasureCounts MUC    with(nolock)
		inner join Denominator_Patient  dp  with(nolock) ON  MUC.pa_id = dp.DenomPatient
		where  1=1    
		and   MUC.MeasureCode    =  @MeasureCode   
		and   MUC.IsNumerator = 1   
		and	  MUC.DateAdded      < @reporting_end_date 
		group by MUC.pa_id   
		  
	)   
   
     select pa_id as Patient,pa_first as FirstName,pa_last as LastName,pat.pa_dob as DateOfBirth,pa_sex as sex,
   pa_address1 as Address1,pa_city as City,pa_state as [State],pa_zip as ZipCode,pa_ssn as chart
   from  dbo.Patients    PAT  with(nolock)      
   inner join Denominator_Patient   DEN  with(nolock) on DEN.DenomPatient   = PAT.pa_id    
   left join Numerator_Patient    NUM  with(nolock) on DEN.DenomPatient = NUM.NumPatient
   where NUM.NumPatient is null 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
