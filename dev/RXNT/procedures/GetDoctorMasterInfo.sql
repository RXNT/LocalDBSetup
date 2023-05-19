SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vijay D
Create date			:	17-September-2020
Description			:	Get Doctor Master login info
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [dbo].[GetDoctorMasterInfo]
	@DoctorId	INT
AS
BEGIN

	SELECT DR.dr_id, LG.LoginId, LG.LicensingProfileId, LG.CompanyId FROM RxNT.dbo.doctors DR WITH(NOLOCK)
	INNER JOIN [dbo].[RsynRxNTMasterLoginExternalAppMaps] LEAM WITH(NOLOCK) ON LEAM.ExternalLoginId = DR.dr_id
	INNER JOIN [dbo].[RsynRxNTMasterLogins] LG WITH(NOLOCK) ON LG.LoginId = LEAM.LoginId
	WHERE DR.dr_id = @DoctorId AND LG.Active = 1 AND DR.dr_enabled = 1

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
