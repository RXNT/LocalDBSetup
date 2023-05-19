SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[UpdateSingleSignOnPartnerPassword]  
AS
BEGIN
	
	UPDATE LI SET 
	PasswordExpiryDate = GETDATE() + 365
	FROM RsynRxNTMasterLogins LI WITH(NOLOCK)
	INNER JOIN  RsynRxNTMasterLoginExternalAppMaps LE WITH(NOLOCK) ON LI.LoginId = LE.LoginId
	INNER JOIN doc_companies dc ON dc.dc_id=Le.ExternalCompanyId
	INNER JOIN PARTNER_ACCOUNTS PA ON PA.PARTNER_ID=dc.partner_id
	WHERE PA.ENABLED=1 AND isSingleSignOn=1 AND LI.PasswordExpiryDate < GETDATE() + 7
	
	UPDATE d
	SET d.password_expiry_date=GETDATE() + 365
	FROM PARTNER_ACCOUNTS PA
	INNER JOIN doc_companies dc ON PA.PARTNER_ID=dc.partner_id
	INNER JOIN doc_groups dg ON dg.dc_id=dc.dc_id
	INNER JOIN doctors d ON d.dg_id=dg.dg_id
	WHERE PA.ENABLED=1 AND isSingleSignOn=1 AND password_expiry_date < GETDATE() + 7
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
