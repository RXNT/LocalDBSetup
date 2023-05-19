SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ===============================================================================================
-- Author		: Rasheed
-- Create date	: 06-MAR-2019
-- Description	: To get user permission
-- ===============================================================================================
CREATE PROCEDURE [adm].[usp_GetUserPermission]
@UserId BIGINT,
@CompanyId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT  DISTINCT dsg.dsg_id,dsg.dsg_desc,dsg.dsg_id_required_ids, CASE WHEN dsgm.dsgm_id IS NULL THEN 0 ELSE 1 END IsSelected
	FROM	[dbo].[doc_security_groups] dsg WITH(NOLOCK)     
	LEFT OUTER JOIN [dbo].[doc_security_group_members] dsgm WITH(NOLOCK) ON dsgm.dr_id=@UserId AND dsgm.dsg_id=dsg.dsg_id
	WHERE dsg.dsg_id IN (7,15)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
