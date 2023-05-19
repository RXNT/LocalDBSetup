SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 11-MAY-2018
-- Description:	Disable Expired Doctor Logins
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [dbo].[DisableExpiredDoctorLogins]
AS
BEGIN

	DECLARE @LicenseTypeId INT
	SELECT @LicenseTypeId= LicenseTypeId FROM [dbo].[RsynRxNTMasterLicenseTypes] WITH(NOLOCK) WHERE Code='PADLS'
	DECLARE @InvoiceStatusId INT

	SELECT @InvoiceStatusId=InvoiceStatusId FROM [dbo].[RsynRxNTMasterInvoiceStatus]  WITH(NOLOCK)  WHERE Code='UPAID'

	UPDATE D SET billingDate=UL.NextBillingDate,D.billing_enabled=1 
	FROM DOCTORS D WITH(NOLOCK)
	INNER JOIN doc_groups dg WITH(NOLOCK) ON d.dg_id=dg.dg_id
	INNER JOIN doc_company_themes dct WITH(NOLOCK) ON dg.dc_id=dct.dc_id
	INNER JOIN [dbo].[RsynRxNTMasterLoginExternalAppMaps] A WITH(NOLOCK) 
	ON D.dr_id=A.ExternalLoginId AND A.ExternalAppId=1
	INNER JOIN [dbo].[RsynRxNTMasterLogins]	C WITH(NOLOCK) ON A.LoginId=C.LoginId
	INNER JOIN dbo.RsynRxNTMasterUserLicenses UL WITH(NOLOCK) ON A.LoginId = UL.LoginId
	WHERE 
	D.DR_ENABLED = 1 
	AND D.prescribing_authority >= 3
	AND not(UL.NextBillingDate is null) AND UL.NextBillingDate <GETDATE()
	AND (D.billingDate is null OR D.billingDate <> UL.NextBillingDate)

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
