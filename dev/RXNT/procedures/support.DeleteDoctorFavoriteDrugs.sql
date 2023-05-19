SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Kalimuthu
-- Create date:  13-SEPTEMBER-2019
-- Description:	 To Delete all favorite drugs by doctor username
-- =============================================
CREATE PROCEDURE [support].[DeleteDoctorFavoriteDrugs]
(
	@LoggedInUserId BIGINT
)
AS
BEGIN

	DECLARE @MainDrId BIGINT;
	
	IF EXISTS(SELECT TOP 1 * FROM doc_fav_drugs WHERE dr_id=@LoggedInUserId)
	BEGIN
		DELETE FROM doc_fav_drugs WHERE dr_id = @LoggedInUserId;
	END
	ELSE
	BEGIN
		SELECT @MainDrId=dr_last_alias_dr_id from doctors where dr_id=@LoggedInUserId
		IF @MainDrId>0
			DELETE FROM doc_fav_drugs WHERE dr_id = @MainDrId;
	END

END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
