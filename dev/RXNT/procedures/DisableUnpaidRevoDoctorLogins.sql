SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 11-MAY-2018
-- Description:	Disable Unpaid Revo Doctor Logins
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [dbo].[DisableUnpaidRevoDoctorLogins]
AS
BEGIN

	DECLARE @LicenseTypeId INT
	SELECT @LicenseTypeId= LicenseTypeId FROM [dbo].[RsynRxNTMasterLicenseTypes] WITH(NOLOCK) WHERE Code='PADLS'
	DECLARE @InvoiceStatusId INT

	SELECT @InvoiceStatusId=InvoiceStatusId FROM [dbo].[RsynRxNTMasterInvoiceStatus]  WITH(NOLOCK)  WHERE Code='IPAID'



	UPDATE D SET
		billingDate=INV.InvoiceDueDate,
		D.billing_enabled=1 
	FROM DOCTORS D WITH(NOLOCK)
	INNER JOIN doc_groups dg WITH(NOLOCK) ON d.dg_id=dg.dg_id
	INNER JOIN doc_company_themes dct WITH(NOLOCK) ON dg.dc_id=dct.dc_id
	INNER JOIN [dbo].[RsynRxNTMasterLoginExternalAppMaps] A WITH(NOLOCK) 
	ON D.dr_id=A.ExternalLoginId AND A.ExternalAppId=1
	INNER JOIN [dbo].[RsynRxNTMasterLogins]	C WITH(NOLOCK) ON A.LoginId=C.LoginId
	INNER JOIN dbo.RsynRxNTMasterUserLicenses UL WITH(NOLOCK) ON A.LoginId = UL.LoginId
	INNER JOIN [dbo].[RsynRxNTMasterLicenseTypes]	E WITH(NOLOCK) ON C.LicenseTypeId=E.LicenseTypeId
	inner join [RsynRxNTMasterInvoiceUserMapping]	IUM WITH(NOLOCK) ON A.LoginId = IUM.LoginId
	INNER JOIN [dbo].[RsynRxNTMasterInvoices]	INV WITH(NOLOCK) ON INV.InvoiceId = IUM.InvoiceId
	WHERE 
	dct.theme_id = 1 --'Revo Theme'
	AND D.DR_ENABLED = 1 
	--AND loginlock = 0 
	AND D.prescribing_authority >= 3
	AND (D.billingDate is null OR D.billingDate <> INV.InvoiceDueDate)
	AND INV.InvoiceDueDate < GETDATE()+30
	AND not(INV.InvoiceDueDate is null)
	AND INV.InvoiceStatusId<>@InvoiceStatusId --1
	AND INV.Active=1
	AND E.LicenseTypeId=@LicenseTypeId -- 2
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
