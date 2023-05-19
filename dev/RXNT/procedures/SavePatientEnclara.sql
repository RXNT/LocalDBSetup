SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Rasheed>
-- Create date: <05-10-2018>
-- Description:	<Save the patient>
-- =============================================
CREATE PROCEDURE [dbo].[SavePatientEnclara]-- Add the parameters for the stored procedure here
	@PatientIdentifier bigint OUTPUT,
	@LastName varchar(50),
	@FirstName varchar(50),
	@PatAddress1 varchar(50),
	@PatAddress2 varchar(50),
	@PatCity varchar(50),
	@PatState varchar(50),
	@PatZip varchar(50),
	@PatHomePhone varchar(50),
	@PatBirthDate datetime,
	@PatGender varchar(50),
	@PatEthnCode varchar(50),
	@PatHeight varchar(50),
	@PatWeight varchar(50),
	@PatMarStat varchar(50),
	@PatMarStatDesc varchar(50),
	@PatAdmitNum varchar(50),
	@pa_ext_ssn_no varchar(50),
	@DCID int,
	@DGID int,
	@PAID int = 0,
	@PatAltId varchar(100) = NULL,
	@IsDischarged BIT = NULL,
	@IsDeceased BIT = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Set @PatientIdentifier=0
	IF(@PAID > 0)
	BEGIN
		UPDATE PATIENTS SET pa_ssn=@PatAdmitNum,pa_last=@LastName,pa_first=@FirstName,pa_address1=@PatAddress1,pa_address2=@PatAddress2,
		pa_city=@PatCity,pa_state=@PatState,pa_zip=@PatZip,pa_phone=@PatHomePhone,pa_dob=@PatBirthDate,pa_sex=@PatGender
		WHERE pa_id = @PAID
		SET @PatientIdentifier=@PAID
	END
	ELSE
	BEGIN
		INSERT INTO patients (dg_id,pa_ssn,pa_last,pa_first,pa_address1,pa_address2,pa_city,pa_state,pa_zip,pa_phone,pa_dob,pa_sex)
		VALUES(@DGID,@PatAdmitNum,@LastName,@FirstName,@PatAddress1,@PatAddress2,@PatCity,@PatState,@PatZip,@PatHomePhone,@PatBirthDate,@PatGender)
		SET @PatientIdentifier=SCOPE_IDENTITY()
	END
	IF @PatAltId IS NOT NULL AND LEN(@PatAltId)>0
	BEGIN
		DECLARE @pik_id BIGINT
		IF NOT EXISTS(select TOP  1 1 
		FROM patient_identifier_keys PK WITH(NOLOCK) 
		WHERE PK.dc_id = @DCID AND PK.keyname = 'AlternativeID')
		BEGIN
			INSERT INTO patient_identifier_keys(dc_id,keyname)
			VALUES(@DCID,'AlternativeID')
			SET @pik_id=SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
			SELECT TOP 1 @pik_id=pik_id
			FROM patient_identifier_keys PK WITH(NOLOCK) 
			WHERE PK.dc_id = @DCID AND PK.keyname = 'AlternativeID'
		END
		IF NOT EXISTS(SELECT * FROM patient_identifiers WITH(NOLOCK) WHERE pa_id=@PatientIdentifier AND pik_id=@pik_id)
		BEGIN
			INSERT INTO patient_identifiers(pa_id,pik_id,value)
			VALUES (@PatientIdentifier,@pik_id,@PatAltId)
		END
		ELSE
		BEGIN
			UPDATE patient_identifiers 
			SET value=@PatAltId
			WHERE pa_id=@PatientIdentifier AND pik_id=@pik_id
		END
	End

	DECLARE @system_flag_id BIGINT
	DECLARE @company_flag_id BIGINT
	IF @IsDischarged IS NOT NULL
	BEGIN
		SELECT TOP 1 @system_flag_id=flag_id FROM patient_flags WHERE flag_title='Discharged' AND dc_id=0 AND is_enabled=1
		SELECT TOP 1 @company_flag_id=flag_id FROM patient_flags WHERE flag_title='Discharged' AND dc_id=@DCID AND is_enabled=1
		IF @IsDischarged=0
		BEGIN
			DELETE FROM patient_flag_details  WHERE pa_id=@PatientIdentifier AND flag_id IN (@system_flag_id,@company_flag_id) 
		END
		ELSE IF @IsDischarged=1 AND NOT EXISTS(SELECT * FROM patient_flag_details WITH(NOLOCK) WHERE pa_id=@PatientIdentifier AND flag_id IN (@system_flag_id,@company_flag_id))
		BEGIN
			INSERT INTO patient_flag_details(pa_id,flag_id,date_added)
			VALUES(@PatientIdentifier, CASE WHEN @company_flag_id>0 THEN @company_flag_id ELSE @system_flag_id END, GETDATE())
		END
	END

	IF @IsDeceased IS NOT NULL
	BEGIN
		SET @system_flag_id = NULL
		SET @company_flag_id = NULL
		SELECT TOP 1 @system_flag_id=flag_id FROM patient_flags WHERE flag_title='Deceased' AND dc_id=0
		SELECT TOP 1 @company_flag_id=flag_id FROM patient_flags WHERE flag_title='Deceased' AND dc_id=@DCID
		IF @IsDeceased=0
		BEGIN
			DELETE FROM patient_flag_details  WHERE pa_id=@PatientIdentifier AND flag_id IN (@system_flag_id,@company_flag_id) 
		END
		ELSE IF @IsDeceased=1 AND NOT EXISTS(SELECT * FROM patient_flag_details WITH(NOLOCK) WHERE pa_id=@PatientIdentifier AND flag_id IN (@system_flag_id,@company_flag_id))
		BEGIN
			INSERT INTO patient_flag_details(pa_id,flag_id,date_added)
			VALUES(@PatientIdentifier, CASE WHEN @company_flag_id>0 THEN @company_flag_id ELSE @system_flag_id END, GETDATE())
		END
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
