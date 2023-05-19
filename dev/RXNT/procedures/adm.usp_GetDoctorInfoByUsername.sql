SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author			: Nambi
-- Create date		: 14-MAR-2023
-- Description		: Get doctor info by username
-- Modified	By		: 
-- Modified Date	: 
-- Modification		:	
-- =============================================
CREATE   PROCEDURE [adm].[usp_GetDoctorInfoByUsername]
	@Username	VARCHAR(50),
	@Email		VARCHAR(50) = NULL
AS

BEGIN
	SET NOCOUNT ON;

	SELECT	GS.dc_Id AS DoctorCompanyId,
			RU.dr_id AS LoginId,
			RU.dr_email AS Email
	FROM doctors RU WITH(NOLOCK)
	INNER JOIN doc_groups GS WITH(NOLOCK) ON RU.dg_id=GS.Dg_id
	INNER JOIN doc_companies DC WITH(NOLOCK) ON GS.dc_id=DC.Dc_id
	WHERE RU.dr_username LIKE @Username
	AND	 (RU.dr_email LIKE @Email OR @Email IS NULL)
	AND  RU.DR_ENABLED = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
