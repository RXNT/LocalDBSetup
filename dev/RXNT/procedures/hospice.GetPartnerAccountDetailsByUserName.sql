SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 25-APR-2018
-- Description:	Get Partner Account Details By UserName
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [hospice].[GetPartnerAccountDetailsByUserName]
	@PartnerUserName			VARCHAR(50)=NULL
AS
BEGIN
	IF @PartnerUserName IS NOT NULL
	BEGIN
		SELECT PARTNER_ID,PARTNER_USERNAME,SALT,PARTNER_PASSWORD,ENABLED,PARTNER_NAME, '' AS Signature
		FROM PARTNER_ACCOUNTS WITH(NOLOCK)
		WHERE PARTNER_USERNAME =  @PartnerUserName
		AND ENABLED=1
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
