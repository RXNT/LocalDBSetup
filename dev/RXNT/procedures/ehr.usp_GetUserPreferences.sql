SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 20-Dec-2016
-- Description:	Get User Preferences
-- =============================================

CREATE PROCEDURE [ehr].[usp_GetUserPreferences]
	@LoggedInUserId BIGINT
AS
BEGIN
	SELECT dr_def_rxcard_history_back_to, dr_rxcard_search_consent_type FROM doctors
	WHERE dr_id=@LoggedInUserId
END
RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
