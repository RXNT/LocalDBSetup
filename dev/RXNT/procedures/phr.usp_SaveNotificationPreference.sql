SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 3-Aug-2022
-- Description:	Insert/update notification preferences
-- =============================================
CREATE PROCEDURE [phr].[usp_SaveNotificationPreference]
	@IsPatientRepresentative BIT,
	@LoggedInUserId BIGINT,
	@Code VARCHAR(10),
	@EnableEmail BIT,
	@EnableSMS BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Get notification id by code
	DECLARE @NotificationId BIGINT = (SELECT NotificationId FROM phr.Notifications notif WHERE notif.Code = @Code)

	-- Update existing text & email notification preference
	UPDATE phr.NotificationPreferences 
	SET EnableEmail = @EnableEmail,
		EnableSMS = @EnableSMS
	WHERE NotificationId = @NotificationId
		AND (
			(@IsPatientRepresentative = 1 AND RepresentativeId = @LoggedInUserId) OR
			(@IsPatientRepresentative = 0 AND PatientId = @LoggedInUserId)
		);

	-- If no custom preference, get new values to insert into table
	IF @@ROWCOUNT = 0
	BEGIN
		DECLARE @PatientId BIGINT = NULL
		DECLARE @RepresentativeId BIGINT = NULL

		IF @IsPatientRepresentative = 1
			SET @RepresentativeId = @LoggedInUserId
		ELSE
			SET @PatientId = @LoggedInUserId


		INSERT phr.NotificationPreferences
			(NotificationId, PatientId, RepresentativeId, EnableSMS, EnableEmail)
		VALUES
			(@NotificationId, @PatientId, @RepresentativeId, @EnableSMS, @EnableEmail)
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
