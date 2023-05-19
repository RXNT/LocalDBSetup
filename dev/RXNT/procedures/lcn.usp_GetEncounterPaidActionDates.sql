SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author				:	Nambi
-- Create date			:	28-AUG-2020
-- Description			:	To get Encounters paid action dates for all providers
-- Last Modified By		:
-- Last Modified Date	:
-- Last Modification	:
-- =============================================

CREATE PROCEDURE [lcn].[usp_GetEncounterPaidActionDates]
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT		LG.LicensingProfileId,
				MAX(enc.dtsigned) LastActionDate
	FROM		dbo.[RsynRxNTMasterLogins] LG WITH(NOLOCK)
				INNER JOIN dbo.[RsynRxNTMasterLoginExternalAppMaps] LEAM WITH(NOLOCK)
					ON	LG.LoginId = LEAM.LoginId
						AND LEAM.ExternalAppId IN (1,13)
				INNER JOIN dbo.doctors DR WITH(NOLOCK) ON DR.dr_id = LEAM.ExternalLoginId
				INNER JOIN dbo.enchanced_encounter ENC WITH(NOLOCK) ON ENC.dr_id = DR.dr_id
	WHERE		1=1 
				AND ENC.dtsigned > GETDATE() - 90
				AND LG.LicensingProfileId IS NOT NULL
	GROUP BY	LG.LicensingProfileId
			
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
