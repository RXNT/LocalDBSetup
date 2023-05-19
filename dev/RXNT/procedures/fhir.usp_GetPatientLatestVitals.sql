SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Vinod  
-- Create date: 03-April-2020
-- Description: Get Patient Condition Details
-- =============================================  
  
CREATE PROCEDURE [fhir].[usp_GetPatientLatestVitals]  --65639803
 @PatientId BIGINT

AS  
BEGIN  
	--DECLARE @PatientFirstName VARCHAR(50)
	--DECLARE @PatientMiddleName VARCHAR(50)
	--DECLARE @PatientLastName VARCHAR(50)
	
	DECLARE @HeightVitalId BIGINT
	DECLARE @Height VARCHAR(50)
	DECLARE @HeightEffectiveDateTime DATETIME
	DECLARE @HeightEncounterId BIGINT
	
	DECLARE @WeightVitalId BIGINT
	DECLARE @Weight VARCHAR(50)
	DECLARE @WeightEffectiveDateTime DATETIME
	DECLARE @WeightEncounterId BIGINT
	
	--SELECT @PatientFirstName=pa_first,@PatientMiddleName=pa_middle,@PatientLastName=pa_last
	--FROM patients pat WITH(NOLOCK) 
	--WHERE pat.pa_id=@PatientId
	
	SELECT TOP 1 @HeightVitalId = [pa_vt_id],@Height = CAST([pa_ht] AS VARCHAR(50)) 
	,@HeightEffectiveDateTime = [record_date] 
	,@HeightEncounterId = pvt.enc_id 
	FROM [dbo].[patient_vitals] pv WITH(NOLOCK)
	LEFT OUTER JOIN dbo.patient_visit pvt with(nolock) ON pv.pa_vt_id = pvt.vital_id
	WHERE pv.pa_id = @PatientId  AND pa_ht>0
	ORDER BY RECORD_DATE DESC
	
	SELECT TOP 1 @WeightVitalId = [pa_vt_id],@Weight = CAST([pa_wt] AS VARCHAR(50)) 
	,@WeightEffectiveDateTime = [record_date] 
	,@WeightEncounterId = pvt.enc_id 
	FROM [dbo].[patient_vitals] pv WITH(NOLOCK)
	LEFT OUTER JOIN dbo.patient_visit pvt with(nolock) ON pv.pa_vt_id = pvt.vital_id
	WHERE pv.pa_id = @PatientId  AND pa_wt>0
	ORDER BY RECORD_DATE DESC
	
	SELECT @PatientId PatientId
	--,@PatientFirstName PatientFirstName
	--,@PatientMiddleName PatientMiddleName
	--,@PatientLastName PatientLastName
	,@HeightVitalId HeightVitalId
	,@Height Height
	,@HeightEffectiveDateTime HeightEffectiveDateTime
	,@HeightEncounterId HeightEncounterId
	,@WeightVitalId WeightVitalId
	,@Weight Weight
	,@WeightEffectiveDateTime WeightEffectiveDateTime 
	,@WeightEncounterId WeightEncounterId
	
	
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
