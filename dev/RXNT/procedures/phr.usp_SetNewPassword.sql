SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Shankar
-- Create date: 19-SEP-2018
-- Description: Change Patient Password
-- =============================================
CREATE PROCEDURE  [phr].[usp_SetNewPassword]
 	@PatientId			BIGINT,
 	@Password			VARCHAR(MAX),
	@Salt               VARCHAR(900)
AS
BEGIN
	
	
	UPDATE	[dbo].[patient_login] 
		SET		pa_password				= @Password,
				last_modified_date		= GETDATE(),
				passwordversion         = '2.0',
				salt                    = @Salt
		WHERE	pa_id			= @PatientId AND enabled = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
