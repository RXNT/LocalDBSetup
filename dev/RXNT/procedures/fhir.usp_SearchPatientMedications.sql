SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Vinod  
-- Create date: 03-April-2020
-- Description: Get Patient Medication Details
-- =============================================  
  
CREATE PROCEDURE [fhir].[usp_SearchPatientMedications]  
 @PatientId BIGINT

AS  
BEGIN  
	DECLARE @PatientFirstName VARCHAR(50)
	DECLARE @PatientMiddleName VARCHAR(50)
	DECLARE @PatientLastName VARCHAR(50)
	
	SELECT @PatientFirstName=pa_first,@PatientMiddleName=pa_middle,@PatientLastName=pa_last
	FROM patients pat WITH(NOLOCK) 
	WHERE pat.pa_id=@PatientId
	
	SELECT CASE WHEN A.DRUG_ID <= -1 THEN A.DRUG_NAME ELSE R.MED_MEDID_DESC END  DRUG_NAME,
	case when A.rxnorm_code is null OR A.rxnorm_code = ''         
		then qry.EVD_EXT_VOCAB_ID         
		else A.rxnorm_code 
		end as RxNormCode
	,A.pa_id PatientId
	,@PatientFirstName PatientFirstName
	,@PatientMiddleName PatientMiddleName
	,@PatientLastName PatientLastName
	,A.days_supply DaysSupply
	,A.dosage Dosage
	,A.comments Notes
	,A.numb_refills NoOfRefills
	,A.duration_amount Quantity
	,A.duration_unit QuantityUnit
	,A.prn IsPRN
	FROM PATIENT_ACTIVE_MEDS A WITH(NOLOCK)  
	LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUG_ID = R.MEDID 
	LEFT OUTER JOIN dbo.Cust_REVDEL0 qry ON  qry.EVD_FDB_VOCAB_ID= A.drug_id  
	WHERE A.pa_id =@PatientId 
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
