SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 17-Aug-2020
-- Description:	Check if a username already exists in AdminV1
-- =============================================
CREATE PROCEDURE [adm].[usp_CheckIfUsernameExistsInAdminV1] 
	@Username VARCHAR(50),
	@V2LoginId BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UsernameExists INT
	DECLARE @V1LoginId BIGINT

	SELECT @V1LoginId = ISNULL((SELECT ExternalLoginId from dbo.RsynRxNTMasterLoginExternalAppMaps where LoginId = @V2LoginId), 0)

	IF exists (
		SELECT doc.dr_id AS 'LoginId', 
			dg.dc_Id AS 'CompanyId', 
			doc.dr_username AS 'Text1' 
		FROM dbo.doctors doc WITH(NOLOCK)
		INNER JOIN dbo.doc_groups dg WITH(NOLOCK) ON doc.dg_id=dg.Dg_id
		WHERE doc.dr_username = @Username
		AND doc.dr_id != @V1LoginId
	)
		BEGIN
			SET @UsernameExists = 1
		END
	
	ELSE 
		BEGIN
			SET @UsernameExists = 0
		END

	SELECT @UsernameExists as 'UsernameAlreadyExists'
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
