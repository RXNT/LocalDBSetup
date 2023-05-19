SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[STAGEII_MISSING_PATIENT_FAMILYHEALTHHISTORY]
@DR_ID INT,  
@REPORTING_START_DATE DATETIME,  
@REPORTING_END_DATE DATETIME

AS   
BEGIN
WITH
 patient_encounters as      
 (      
  select distinct enc.patient_id     
  from  dbo.enchanced_encounter  enc  with(nolock)      
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id      
  where  1=1      
  and   enc.dr_id  = @dr_id      
  and   enc.enc_date between @reporting_start_date and @reporting_end_date
  and enc.issigned = 1   
 ),      
      
 Numerator_Data as      
 (    
  select  distinct pat_id as Numerator      
  from  patient_family_hx hx with(nolock)      
  inner join  patient_encounters enc with(nolock) on enc.patient_id = hx.pat_id      
  where  1=1      
  ---and hx.created_on between @reporting_start_date and @reporting_end_date      
  ---and hx.dr_id = @dr_id              
 ),      
      
 Denominator_Data as      
 (      
  select  distinct enc.patient_id as Denominator     
  from  patient_encounters  enc  with(nolock)      
  inner join dbo.patients    pat  with(nolock) on pat.pa_id  = enc.patient_id      
  where  1=1      
  -- and   enc.dr_id  = @dr_id      
 -- and   enc.enc_date between @reporting_start_date and @reporting_end_date              
 )      
       
 SELECT  DISTINCT P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,    
	P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART   
	FROM PATIENTS P  WITH(NOLOCK) 
	INNER JOIN DENOMINATOR_DATA DD ON P.PA_ID = DD.DENOMINATOR
	LEFT OUTER JOIN NUMERATOR_DATA ND ON P.PA_ID = ND.NUMERATOR
	WHERE 1=1
    AND ND.NUMERATOR  IS NULL  
END

exec STAGEII_MISSING_PATIENT_FAMILYHEALTHHISTORY 9161,'2013-07-01','2014-07-31'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
