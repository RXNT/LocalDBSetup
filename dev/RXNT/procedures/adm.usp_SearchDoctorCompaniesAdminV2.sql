SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 23-Mar-2015
-- Description:	to fetch list of Doctor Companies from external application
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchDoctorCompaniesAdminV2]
	@CompanyName VARCHAR(80) = NULL,
	@GroupName VARCHAR(80) = NULL,
	@CompanyId BIGINT = NULL
AS

BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT EDC.dc_name As Name,
		   EDC.dc_id AS CompanyId, EDC.dc_host_id AS ServerId
	FROM doc_companies EDC WITH(NOLOCK)
	INNER JOIN doc_groups DG WITH(NOLOCK) ON EDC.dc_id = DG.dc_id
	WHERE	(EDC.dc_name LIKE '%' + @CompanyName + '%'OR @CompanyName IS NULL) AND
			(DG.dg_name LIKE '%' + @GroupName + '%' OR @GroupName IS NULL) AND 
			(ISNULL(@CompanyId,0) = 0 OR EDC.dc_id = @CompanyId )
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
