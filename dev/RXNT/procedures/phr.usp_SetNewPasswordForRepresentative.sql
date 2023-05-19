SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Shankar
-- Create date: 01-OCT-2018
-- Description: Change Representative Password
-- =============================================
CREATE PROCEDURE  [phr].[usp_SetNewPasswordForRepresentative]
 	@PatientRepresentativeId			BIGINT,
 	@Password			VARCHAR(MAX),
	@Salt               VARCHAR(900)
AS
BEGIN
	
	
	UPDATE	[phr].[PatientRepresentativesInfo] 
		SET		Text2				= @Password,
				Text3               = @Salt,
				ModifiedDate	= GETDATE()
		WHERE	PatientRepresentativeId	= @PatientRepresentativeId AND Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
