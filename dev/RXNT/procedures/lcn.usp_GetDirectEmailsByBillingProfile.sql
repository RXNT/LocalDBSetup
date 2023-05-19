SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Shankar 
Create date			: 23-May-2019
Description			: To fetch Direct Emails 
Last Modified By	: Vipul
Last Modifed Date	: 12-July-2019
======================================================================================= 
*/ 
CREATE PROCEDURE [lcn].[usp_GetDirectEmailsByBillingProfile] 
	@DoctorCompanyIds VARCHAR(8000)
AS 
BEGIN 
	SET NOCOUNT ON; 

	SELECT  COM.dc_id,
        COM.Dc_Name AS CompanyName,
		DEA.OwnerEntityID,
		DEA.DirectAddressPrefix + '@' + DED.DirectDomainPrefix + '.direct.rxnt.com' AS DirectAddress ,
		null AS DirectDomainID,
		null AS [Certificate],
		1 AS Active


	FROM dbo.doc_companies COM
	INNER JOIN dbo.doc_groups   DG WITH(NOLOCK) ON DG.dc_id = COM.dc_id
	INNER JOIN  dbo.doctors DOC WITH(NOLOCK) ON DOC.dg_id = DG.dg_id
	INNER JOIN  [dbo].[direct_email_addresses] DEA WITH(NOLOCK) ON  DEA.OwnerEntityId = DOC.dr_id AND DEA.DirectAddressOwnerType = 1
	INNER JOIN [dbo].[direct_email_domains] DED WITH(NOLOCK) ON DED.DirectDomainID = DEA.DirectDomainID
	WHERE COM.dc_id IN ((SELECT *  FROM dbo.SplitString(@DoctorCompanyIds, ',')) ) AND DOC.dr_enabled =1
	UNION  
	SELECT  COM.dc_id,
        COM.Dc_Name AS CompanyName,
		null AS OwnerEntityID,
		null AS DirectAddress,
		DED.DirectDomainID,
		DED.DirectDomainPrefix+'.direct.rxnt.com' AS [Certificate],
		1 AS Active

	FROM dbo.doc_companies COM
	INNER JOIN dbo.doc_groups   DG WITH(NOLOCK) ON DG.dc_id = COM.dc_id
	INNER JOIN  dbo.doctors DOC WITH(NOLOCK) ON DOC.dg_id = DG.dg_id
	INNER JOIN  [dbo].[direct_email_addresses] DEA WITH(NOLOCK) ON DEA.OwnerEntityID = DOC.dr_id
	INNER JOIN [dbo].[direct_email_domains] DED WITH(NOLOCK) ON DED.DirectDomainID = DEA.DirectDomainID
	WHERE COM.dc_id IN ((SELECT *  FROM dbo.SplitString(@DoctorCompanyIds, ',')) ) AND DOC.dr_enabled =1
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
