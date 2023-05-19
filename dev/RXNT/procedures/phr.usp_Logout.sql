SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram G
-- Create date: 29-NOV-2017
-- Description:	Patient Logout
-- =============================================
CREATE PROCEDURE  [phr].[usp_Logout]
(
  @DoctorCompanyId	BIGINT,
  @Token				VARCHAR(900) = NULL,
  @LoggedInUserId		BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [dbo].[PatientTokens]
	SET Active			= 0,
	    InactivatedBy	= @LoggedInUserId,
	    InactivatedDate = GETDATE()
	WHERE Token = @Token				AND
		  DoctorCompanyId = @DoctorCompanyId	AND
		  PatientId   = @LoggedInUserId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
