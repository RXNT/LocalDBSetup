SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 10-Aug-2020
-- Description:	Get all adminV1 users for unique username validation
-- =============================================
CREATE PROCEDURE [adm].[usp_GetAllAdminV1UsersForValidation]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT doc.dr_id AS 'LoginId', 
		dg.dc_Id AS 'CompanyId', 
		doc.dr_username AS 'Text1' 
	FROM dbo.doctors doc
	INNER JOIN dbo.doc_groups dg WITH(NOLOCK) ON doc.dg_id=dg.Dg_id
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
