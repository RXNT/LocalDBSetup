SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 05/08/2018
-- Description:	disable all non-paying licensed users when all paying users are disabled
-- =============================================
CREATE PROCEDURE [dbo].[usp_DisableAllNonPayingUsersJob]
AS
BEGIN 
	SET NOCOUNT ON;

 --   DECLARE @LicenseTypeId INT
 --   DECLARE @InvoiceStatusId INT
	
	--SELECT @LicenseTypeId= LicenseTypeId 
	--FROM [dbo].[RsynRxNTMasterLicenseTypes] WITH(NOLOCK) 
	--WHERE Code='PADLS'


	SELECT DG.dg_id,SUM(CASE WHEN d.dr_enabled=1 THEN 1 ELSE 0 END) NoOfActiveUsers
	INTO #V1PaidCompanies
	FROM DOCTORS D WITH(NOLOCK)
	INNER JOIN doc_groups DG WITH(NOLOCK) ON D.dg_id = DG.dg_id
	INNER JOIN doc_companies DC with(nolock) on DG.dc_id = DC.dc_id
	WHERE  D.prescribing_authority > 2
	GROUP BY DG.dg_id 
 
	UPDATE D SET dr_enabled=0
	FROM doctors D WITH(NOLOCK)
	INNER JOIN doc_groups DG WITH(NOLOCK) ON D.dg_id = DG.dg_id
	INNER JOIN #V1PaidCompanies PC WITH(NOLOCK) ON DG.dg_id = PC.dg_id 
	WHERE PC.NoOfActiveUsers=0  AND D.dr_enabled=1
	 
	-- SELECT D.dr_id,D.prescribing_authority FROM doctors D WITH(NOLOCK)
	--INNER JOIN doc_groups DG WITH(NOLOCK) ON D.dg_id = DG.dg_id
	--INNER JOIN #V1PaidCompanies PC WITH(NOLOCK) ON DG.dg_id = PC.dg_id 
	--WHERE PC.NoOfActiveUsers=0  AND D.dr_enabled=1

	DROP TABLE #V1PaidCompanies
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
