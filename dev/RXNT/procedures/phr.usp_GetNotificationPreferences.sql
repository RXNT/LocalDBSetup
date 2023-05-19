SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 18-July-2022
-- Description:	Get custom user notification preferences or 
--				default notification preferences if user hasn't 
--				customized their preferences.
-- =============================================
CREATE PROCEDURE [phr].[usp_GetNotificationPreferences] 
	@IsPatientRepresentative BIT,
	@LoggedInUserId BIGINT
AS
BEGIN

	SET NOCOUNT ON;

	SELECT ISNULL(pref.NotificationPreferenceId, notif.NotificationId) as 'NotificationPreferenceId',
			notif.Code,
			ISNULL(pref.EnableSMS, notif.EnableSMS) as 'EnableSMS',
			ISNULL(pref.EnableEmail, notif.EnableEmail) as 'EnableEmail',
			ISNULL(pref.EnablePush, notif.EnablePush) as 'EnablePush'
	FROM phr.Notifications notif WITH(NOLOCK)
	LEFT JOIN phr.NotificationPreferences pref ON pref.NotificationId = notif.NotificationId
	WHERE
		(@IsPatientRepresentative = 1 AND pref.RepresentativeId = @LoggedInUserId) OR
		(@IsPatientRepresentative = 0 AND pref.PatientId = @LoggedInUserId)

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
