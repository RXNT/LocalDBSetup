SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 2-Apr-2015
-- Description:	Update the password from AdminV2 AngularJS site
-- =============================================
CREATE PROCEDURE [adm].[SaveUserPasswordAdminV2] 
	@DoctorId BIGINT,
	@Password VARCHAR(100),
	@Salt VARCHAR(100),
	@Email VARCHAR(50),
	@isMigrated BIT,
	@isPasswordExpiryDate BIT
AS
BEGIN
	DECLARE @PasswordExpiryDate DATETIME2;
	
	IF (ISNULL(@isPasswordExpiryDate,0) = 1 )
	BEGIN
			SET @PasswordExpiryDate = DATEADD(YY, 1, GETDATE());
	END
	ELSE
	BEGIN
			SET @PasswordExpiryDate = GETDATE();
	END
	
	
	IF @isMigrated = 1 
	BEGIN
		UPDATE doctors 
		SET 
			dr_password = @Password , 
			salt=@salt,
			isMigrated = @isMigrated,
			dr_email = @Email,
			password_expiry_date = @PasswordExpiryDate
		WHERE dr_id = @DoctorId
	END
	ELSE
	BEGIN
		UPDATE doctors 
		SET 
			dr_password = @Password , 
			salt=@salt,
			dr_email = @Email,
			password_expiry_date = @PasswordExpiryDate
		WHERE dr_id = @DoctorId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
