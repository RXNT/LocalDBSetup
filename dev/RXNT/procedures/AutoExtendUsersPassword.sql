SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[AutoExtendUsersPassword]  
AS
BEGIN

UPDATE LI SET 
PasswordExpiryDate = GETDATE() + 365
FROM synRxNTMasterLogins LI WITH(NOLOCK)
INNER JOIN  synRxNTMasterLoginExternalAppMaps LE WITH(NOLOCK) ON LI.LoginId = LE.LoginId AND ExternalAppId=1
INNER JOIN doc_companies dc ON dc.dc_id=Le.ExternalCompanyId
INNER JOIN doc_groups dg ON dg.dc_id=dc.dc_id
INNER JOIN doctors d ON d.dg_id=dg.dg_id AND d.dr_id = LE.ExternalLoginId
INNER JOIN PARTNER_ACCOUNTS PA ON PA.PARTNER_ID=dc.partner_id
WHERE PA.ENABLED=1 AND PA.PARTNER_ID IN (20/*'SnapMd'*/) AND  LI.PasswordExpiryDate < GETDATE() + 7

UPDATE d
SET d.password_expiry_date=GETDATE() + 365
FROM PARTNER_ACCOUNTS PA
INNER JOIN doc_companies dc ON PA.PARTNER_ID=dc.partner_id
INNER JOIN doc_groups dg ON dg.dc_id=dc.dc_id
INNER JOIN doctors d ON d.dg_id=dg.dg_id
WHERE PA.ENABLED=1 AND PA.PARTNER_ID IN (20/*'SnapMd'*/) AND password_expiry_date < GETDATE() + 7 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
