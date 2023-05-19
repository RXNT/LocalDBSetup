SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author				:	Nambi
-- Create date			:	28-AUG-2020
-- Description			:	To get EPCS Prescriptions paid action dates for all providers
-- Last Modified By		:
-- Last Modified Date	:
-- Last Modification	:
-- =============================================

CREATE PROCEDURE [lcn].[usp_GetEPCSPrescriptionPaidActionDates]
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT		LG.LicensingProfileId,
				MAX(PR.pres_approved_date) LastActionDate
	FROM		dbo.[RsynRxNTMasterLogins] LG WITH(NOLOCK)
				INNER JOIN dbo.[RsynRxNTMasterLoginExternalAppMaps] LEAM WITH(NOLOCK) ON LEAM.LoginId = LG.LoginId  AND LEAM.ExternalAppId IN (1,13)
				INNER JOIN dbo.doctors DR WITH(NOLOCK) ON DR.dr_id = LEAM.ExternalLoginId
				INNER JOIN dbo.prescriptions PR WITH(NOLOCK) ON PR.dr_id = DR.dr_id AND PR.dg_id = DR.dg_id
	WHERE		1=1
				AND DR.epcs_enabled = 1 
				AND PR.pres_approved_date IS NOT NULL
				AND PR.pres_approved_date > GETDATE() - 90
				AND PR.is_signed = 1
				AND LG.LicensingProfileId IS NOT NULL
	GROUP BY	LG.LicensingProfileId
			
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
