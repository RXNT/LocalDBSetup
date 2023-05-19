SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:    Michael Cheever
-- Create date: 06/21/2022
-- Description:	Get weavy config for patients
-- =============================================
CREATE     PROCEDURE [dbo].[GetWeavyPatientConfig] (@PatientId BIGINT = NULL,
@CompanyId BIGINT = NULL)
AS
BEGIN
  SET NOCOUNT ON;

  SELECT
    'pa_' + CAST(pl.[pa_login_id] AS VARCHAR(10))AS Username,
    'pa_dir_' + CAST(pl.[pa_login_id] AS VARCHAR(10)) AS Directory,
    CASE WHEN LEN(pa.[pa_middle]) > 0 THEN pa.[pa_first] + ' ' + pa.[pa_middle] + ' ' + pa.[pa_last]
			 ELSE pa.[pa_first] + ' ' + pa.[pa_last] 
		END 'Name',
    CASE
      WHEN pl.[WeavyId] IS NULL THEN 1
      ELSE 0
    END AS IsWeavyAccountCreationRequired,
	cem.[CompanyId] AS CompanyId,
	ccc.[CompanyId] AS CorporateCompanyId,
	pl.[pa_login_id] AS LoginId
  FROM [RXNT].[dbo].[patient_login] pl WITH(NOLOCK)
	INNER JOIN [RXNT].[dbo].[patients] pa WITH(NOLOCK) ON pl.[pa_id] = pa.[pa_id]
	INNER JOIN [RxNT].[dbo].[doc_groups] gr WITH(NOLOCK) ON pa.[Dg_Id] = gr.[Dg_Id]
	INNER JOIN [RxNT].[dbo].[doc_companies] co WITH(NOLOCK) ON co.[Dc_Id] = gr.[Dc_Id]
	INNER JOIN [dbo].[RsynMasterCompanyExternalAppMaps] cem WITH(NOLOCK) ON co.[dc_id] = cem.[ExternalCompanyId]
	LEFT JOIN [dbo].[RsynMasterCorporateClientCompanyMaps] ccc WITH(NOLOCK) ON ccc.[ClientCompanyId] = cem.[CompanyId]
  WHERE pl.[pa_id] = @PatientId
  AND co.[Dc_Id] = @CompanyId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
