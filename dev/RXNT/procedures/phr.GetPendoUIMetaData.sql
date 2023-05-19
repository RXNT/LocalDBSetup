SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip
-- Create date: 08/24/2021
-- Description:	Fetch patient metadata to be send to pendo
-- =============================================
CREATE PROCEDURE [phr].[GetPendoUIMetaData]
	-- Add the parameters for the stored procedure here
	@PatientId BigInt,
	@PatientRepresentativeId BigInt = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
		PropertyTypes : 0 - String , 1 - Integer, 2 - DateTime , 3 - Boolean
	*/
	SET NOCOUNT ON;

	DECLARE @IsFirstLogin BIT = 1
	DECLARE @DateCreated VARCHAR(50)
	DECLARE @LoginId VARCHAR(50)
	Declare @AccountType VARCHAR(50)

	IF((SELECT COUNT(*) FROM [patient_phr_access_log] WITH(NOLOCK) where pa_id = @PatientId) > 1)
	BEGIN
		SET @IsFirstLogin = 0
	END
   
	SELECT @DateCreated = add_date FROM patients WITH(NOLOCK) WHERE pa_id = @PatientId
	SELECT @LoginId = ('PA_' + CAST(pa_login_id AS VARCHAR(50))) FROM patient_login WHERE pa_id = @PatientId

	select @AccountType = 
	CASE
		WHEN @PatientRepresentativeId > 0 THEN 'Representative'
		ELSE 'Patient' 
	END


	SELECT '_PHRLoginID' PendoKey, CAST(@LoginId AS VARCHAR(50)) PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_DateCreated' PendoKey, CAST(@DateCreated AS VARCHAR(50)) PendoValue, 2 PropertyType, 1 PendoActive UNION
	SELECT '_UserLoggedInForFirstTime' PendoKey, CAST(@IsFirstLogin AS VARCHAR(50)) PendoValue, 3 PropertyType, 1 PendoActive UNION
	SELECT '_AccountType' PendoKey, CAST(@AccountType AS VARCHAR(50)) PendoValue, 0 PropertyType, 1 PendoActive UNION
	-- default visitor data for patient account
	SELECT '_ActivatedForReleaseToBilling' PendoKey, 'PatientAccount' PendoValue,0 PropertyType, 1 PendoActive UNION
	SELECT '_ActivatedIDProofing' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_BillingLockDate' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_ClinicalAdministrator' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_DirectEmailEnabled' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_DRID' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_Email' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_EnabledDisabledStatus' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_EPCSEnabled' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_LoginId' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_LoginName' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_NumberOfDaysUntilPasswordExpiration' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_PartnerAccountName' PendoKey,'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_Role' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_Speciality' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_UserLevelInLegacyAdmin' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_V2EncounterTemplateEnabledForUser' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT '_PracticeState' PendoKey, 'PatientAccount' PendoValue, 0 PropertyType, 1 PendoActive UNION
	SELECT 'id' PendoKey, @LoginId PendoValue, 0 PropertyType, 1 PendoActive

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
