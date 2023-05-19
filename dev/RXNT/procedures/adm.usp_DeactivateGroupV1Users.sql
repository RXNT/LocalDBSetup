SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: VIPUL JAIN
Create date			: 17-MAR-2021
Description			: To Deactivate all users if location is deactivated
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [adm].[usp_DeactivateGroupV1Users]
(
	@V1GroupId BIGINT,
	@LoggedInUserId BIGINT
)
AS 
BEGIN 
	SET NOCOUNT ON; 

	UPDATE		DA
	SET			DA.dr_partner_enabled = 0,
				DA.dr_service_level = 0,
				DA.update_date = GETDATE()
	FROM		dbo.doc_admin DA WITH(NOLOCK)
				INNER JOIN dbo.doctors DR WITH(NOLOCK) ON DA.dr_id = DR.dr_id 
	WHERE		DR.dg_id = @V1GroupId 
				AND DR.dr_enabled = 1

	UPDATE		DR
	SET			DR.dr_enabled = 0,
				DR.beta_tester = 0,
				DR.dr_view_group_prescriptions = 0
	FROM		dbo.doctors DR
	WHERE		DR.dg_id = @V1GroupId 
				AND DR.dr_enabled = 1

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
