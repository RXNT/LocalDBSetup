SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[STAGEII_MISSING_PATIENT_DEMOGRAPHICS]
@DR_ID INT,    
@REPORTING_START_DATE DATETIME,    
@REPORTING_END_DATE DATETIME  

AS     
BEGIN  
WITH  
patient_encounters as 
 ( 
 select distinct enc.patient_id
 from dbo.enchanced_encounter enc with(nolock) 
 inner join dbo.patients pat with(nolock) on pat.pa_id = enc.patient_id 
 where 1=1 
 and enc.dr_id = @dr_id 
 and enc.enc_date between @reporting_start_date and @reporting_end_date
 and enc.issigned = 1 
 )
SELECT  DISTINCT P.PA_ID AS PATIENT,P.PA_FIRST AS FIRSTNAME, P.PA_LAST AS LASTNAME, P.PA_DOB AS DATEOFBIRTH, P.PA_SEX AS SEX,  
    P.PA_ADDRESS1 AS ADDRESS1, P.PA_CITY AS CITY,  
    P.PA_STATE AS STATE, P.PA_ZIP AS ZIPCODE,P.PA_SSN AS CHART 
    FROM PATIENTS P  with(nolock)
    INNER JOIN patient_encounters pe on P.pa_id=pe.patient_id
    WHERE P.PREF_LANG < 1 
    OR P.PA_RACE_TYPE < 1
    OR P.PA_SEX IS NULL 
    OR P.PA_DOB IS NULL
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
