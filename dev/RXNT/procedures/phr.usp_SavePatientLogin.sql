SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SavePatientLogin] 
	@PatientId bigint,
	@Username Varchar(50),
	@Email Varchar(100),
	@Phone Varchar(50),
	@Salt Varchar(200),
	@Password Varchar(500),
	@Signature Varchar(200)
	
AS
BEGIN

    DECLARE @DoesDisabledLoginWithSameUsernameExistForPatient INT = 0;

    SELECT @DoesDisabledLoginWithSameUsernameExistForPatient = CASE WHEN EXISTS (
            SELECT pa_login_id FROM dbo.patient_login 
            WHERE pa_id = @PatientId
                AND enabled = 0
                AND pa_username = @Username
        )
        THEN 1
        ELSE 0
    END

    IF (@DoesDisabledLoginWithSameUsernameExistForPatient = 1)
        BEGIN
            UPDATE dbo.patient_login
            SET pa_password = @Password,
                pa_email = @Email,
                pa_phone = @Phone,
                salt = @Salt,
                signature = @Signature,
                passwordversion = '2.0',
                enabled = 1,
                inactivated_by = null,
                inactivated_date = null,
                last_modified_by = @PatientId,
                last_modified_date = GETDATE(),
                accepted_terms_date = null
            WHERE pa_id = @PatientId
            AND enabled = 0
        END
    ELSE
        BEGIN
            INSERT INTO PATIENT_LOGIN (PA_ID, PA_USERNAME, PA_PASSWORD, PA_EMAIL, PA_PHONE, SALT, signature,PASSWORDVERSION) 
            VALUES(@PatientId, @Username, @Password, @Email, @Phone, @Salt,@Signature,'2.0')
        END
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
