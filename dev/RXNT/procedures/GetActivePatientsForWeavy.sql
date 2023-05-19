SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Michael Cheever
-- Create date: 05-31-2022
-- Description:	Get patients to be added to weavy
-- =============================================

CREATE   PROC [dbo].[GetActivePatientsForWeavy]
AS
BEGIN
	SELECT DISTINCT pl.pa_login_id 'loginId',
		pl.[pa_id] 'id',
		CASE WHEN LEN(pa.pa_middle) > 0 THEN pa.pa_first + ' ' + pa.pa_middle + ' ' + pa.pa_last
			 ELSE pa.pa_first + ' ' + pa.pa_last 
		END 'name',
		cem.[CompanyId] 'companyId',
		ccc.[CompanyId] 'corporateCompanyId'
	FROM [RXNT].[dbo].[patient_login] pl WITH(NOLOCK)
	INNER JOIN [RXNT].[dbo].[patients] pa WITH(NOLOCK) ON pl.pa_id = pa.pa_id
	INNER JOIN [RxNT].[dbo].[doc_groups] gr WITH(NOLOCK) ON pa.[Dg_Id] = gr.[Dg_Id]
	INNER JOIN [RxNT].[dbo].[doc_companies] co WITH(NOLOCK) ON co.[Dc_Id] = gr.[Dc_Id]
	INNER JOIN [RsynMasterCompanyExternalAppMaps] cem WITH(NOLOCK) ON co.dc_id = cem.[ExternalCompanyId]
	LEFT JOIN [RsynMasterCorporateClientCompanyMaps] ccc WITH(NOLOCK) ON ccc.[ClientCompanyId] = cem.[CompanyId]
	WHERE pl.[WeavyId] IS NULL
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
