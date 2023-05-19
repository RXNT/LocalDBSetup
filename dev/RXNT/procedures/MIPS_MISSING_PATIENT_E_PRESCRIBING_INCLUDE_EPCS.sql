SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 --=============================================        
 --Author:  RxNT        
 --Create date: 28/07/2014        
 --Description: Procedure to get the measures non 
 --				qualifying data for Clinical  
 --				Summary  
 --=============================================        
CREATE PROCEDURE [dbo].[MIPS_MISSING_PATIENT_E_PRESCRIBING_INCLUDE_EPCS]        
 @dr_id int, 
 @reporting_start_date date,
 @reporting_end_date date ,
 @measureCode varchar(10)       
AS        
BEGIN

SET NOCOUNT ON;        
	
with measures_data as      
 (      
  select  @MeasureCode as MeasureCode, @dr_id as dr_id      
 ),      
   
 Denominator_Patient as      
 (
	  select distinct pa_id as DenomPatient 
	  from prescriptions p 
	  inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
	  inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
	  where 
	  p.dr_id = @dr_id and 
	  p.pres_delivery_method > 2 and
	  p.pres_void = 0 and
	  p.pres_approved_date between @reporting_start_date and @reporting_end_date      
 ), 
 Numerator_Patient as      
 (
 
	  select distinct pa_id as NumPatient
	  from prescriptions p 
	  inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
	  inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
	  where 
	  p.dr_id = @dr_id and
	  p.pres_void = 0 and
	  p.pres_approved_date between @reporting_start_date and @reporting_end_date 

   ) 
   /*
   select 
   pa_id as Patient,
   pa_first as FirstName,
   pa_last as LastName,
   pat.pa_dob as DateOfBirth,
   pa_sex as sex,
   pa_address1 as Address1,
   pa_city as City,
   pa_state as [State],
   pa_zip as ZipCode,
   pa_ssn as chart
   from  dbo.Patients    PAT  with(nolock) where 1=1
   AND pat.pa_id in 
   ( 
		select distinct 
		np.NumPatient from Numerator_Patient np
   )*/
   
   SELECT  DISTINCT P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
	P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
	FROM PATIENTS P  WITH(NOLOCK) 
	INNER JOIN Denominator_Patient DD ON P.PA_ID = DD.DenomPatient
	LEFT OUTER JOIN Numerator_Patient ND ON P.PA_ID = ND.NumPatient
	WHERE 1=1
    AND ND.NumPatient IS NULL 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
