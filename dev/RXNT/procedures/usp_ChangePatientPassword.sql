SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Change Patient Password
-- =============================================
CREATE PROCEDURE  [dbo].[usp_ChangePatientPassword]
 	@PatientId			BIGINT,
 	@LoggedInUserId		BIGINT,
 	@Password			VARCHAR(500)
AS
BEGIN
	
	
	UPDATE	[dbo].[patient_login] 
		SET		pa_password				= @Password,
				last_modified_by		= @LoggedInUserId, 
				last_modified_date		= GETDATE(),
				passwordversion         = '2.0'
		WHERE	pa_id			= @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
