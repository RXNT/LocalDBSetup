SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 23-Mar-2015
-- Description:	to fetch list of Doctor Groups from EHR database
-- Modified By: jagadeesh
-- Modified Date: 31-MAR-2015
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchDoctorGroupsAdminV2]
	@DoctorCompanyName VARCHAR(200),
	@DoctorGroupName VARCHAR(80) = NULL,
	@DoctorCompanyId bigint = NULL
AS

BEGIN
	SET NOCOUNT ON;
	
	
	SELECT DISTINCT DG.dg_id As GroupId,
		   DG.dc_id As CompanyId,
		   DG.dg_name As Name
	FROM doc_groups DG WITH(NOLOCK)
	INNER JOIN doc_companies CMP WITH(NOLOCK)
	ON DG.dc_id = CMP.dc_id
	WHERE (ISNULL(@DoctorCompanyName,'') = '' OR CMP.dc_name LIKE '%' + @DoctorCompanyName + '%') 
	AND   (ISNULL(@DoctorGroupName,'') = '' OR DG.dg_name LIKE '%' + @DoctorGroupName + '%') 
	AND  (ISNULL(@DoctorCompanyId,0) = 0 OR dg.dc_id = @DoctorCompanyId)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
