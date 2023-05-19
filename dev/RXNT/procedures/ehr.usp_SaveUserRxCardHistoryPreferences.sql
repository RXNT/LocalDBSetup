SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 10-May-2016
-- Description:	Save User RxCard History Preferences
-- =============================================

CREATE PROCEDURE [ehr].[usp_SaveUserRxCardHistoryPreferences]
	@LoggedInUserId BIGINT,
	@RxCardConsentType VARCHAR(1)=NULL,
	@ClaimsPeriod SMALLINT=NULL
AS
BEGIN

	UPDATE doctors 
	SET dr_def_rxcard_history_back_to=ISNULL(@ClaimsPeriod,dr_def_rxcard_history_back_to), 
	dr_rxcard_search_consent_type= ISNULL(@RxCardConsentType,dr_rxcard_search_consent_type) 
	WHERE dr_id=@LoggedInUserId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
