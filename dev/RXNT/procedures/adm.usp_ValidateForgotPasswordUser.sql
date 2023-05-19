SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kanniyappan
-- Create date: 17-July-2016
-- Description:	Validate user with Email,First & Last Name for forgot password
-- Modified	By: 
-- Modified Date : 
-- Description:	
-- =============================================
CREATE PROCEDURE [adm].[usp_ValidateForgotPasswordUser]
	@UserName			VARCHAR(50),
	@Email				VARCHAR(50)
AS

BEGIN
	
	SET NOCOUNT ON;
	
	SELECT 	RU.dr_id,RU.dr_username,RU.dr_enabled,RU.dr_email As Email,RU.IsEmailVerified,RU.IsEmailVerificationPending
	FROM	doctors RU WITH(NOLOCK)
	WHERE	RU.dr_username = @UserName
	
END
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
