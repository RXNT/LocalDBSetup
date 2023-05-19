SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 30-7-2018
-- Description:	to fetch Doctor Company Server
-- =============================================
CREATE PROCEDURE [adm].[usp_GetDoctorCompanyServer]
	
	@CompanyId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT  EDC.dc_host_id 
	FROM doc_companies EDC WITH(NOLOCK)
	WHERE ISNULL(@CompanyId,0) = 0 OR EDC.dc_id = @CompanyId 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
