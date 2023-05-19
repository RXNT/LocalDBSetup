SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 17-APR-2018
-- Description:	Disable Unpaid Doctor Logins
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [dbo].[DisableUnpaidDoctorLogins]
	
AS
BEGIN
	DECLARE @LicenseTypeId INT
	SELECT @LicenseTypeId= LicenseTypeId FROM [dbo].[RsynRxNTMasterLicenseTypes] WITH(NOLOCK) WHERE Code='PADLS'
	DECLARE @InvoiceStatusId INT
	
	SELECT @InvoiceStatusId=InvoiceStatusId FROM [dbo].[RsynRxNTMasterInvoiceStatus]  WITH(NOLOCK)  WHERE Code='IPAID'
	
	UPDATE D SET billingDate=INV.InvoiceDueDate,D.billing_enabled=1 
	FROM DOCTORS D WITH(NOLOCK)
	INNER JOIN [dbo].[RsynRxNTMasterLoginExternalAppMaps] A WITH(NOLOCK) ON D.dr_id=A.ExternalLoginId AND A.ExternalAppId=1
	INNER JOIN [dbo].[RsynRxNTMasterLogins] C WITH(NOLOCK) ON A.LoginId=C.LoginId
	INNER JOIN [dbo].[RsynRxNTMasterInvoiceUserMapping] B WITH(NOLOCK) ON B.LoginId = C.LoginId
	INNER JOIN [dbo].[RsynRxNTMasterLicenseTypes] E WITH(NOLOCK) ON C.LicenseTypeId=E.LicenseTypeId
	INNER JOIN [dbo].[RsynRxNTMasterInvoices] INV WITH(NOLOCK) ON INV.InvoiceId = B.InvoiceId
	WHERE D.DR_ENABLED = 1 AND loginlock = 0 AND D.prescribing_authority >= 3
	AND INV.InvoiceDueDate < getdate() AND INV.InvoiceStatusId<>@InvoiceStatusId AND INV.Active=1
	AND E.LicenseTypeId=@LicenseTypeId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
