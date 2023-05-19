SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Afsal Y
-- Create date: 03-Oct-2017
-- Description:	DP-57
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveUserEmailAdminV2] 
	@DoctorId BIGINT,
	@Username	VARCHAR(100),
	@Email VARCHAR(50)
AS
BEGIN
	UPDATE doctors 
	SET 
		dr_email = @Email
	WHERE dr_id = @DoctorId AND dr_username = @Username
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
