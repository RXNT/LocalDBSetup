SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ===============================================================================================
-- Author		: Vinod Kumar
-- Create date	: 30-July-2018
-- Description	: To fetch list of All Doctor COmpany Hosts
-- ===============================================================================================
CREATE PROCEDURE [adm].[usp_GetAllDoctorCompanyHosts]
AS

BEGIN
	SET NOCOUNT ON;
	SELECT  *
	FROM	doc_company_hosts WITH(NOLOCK)     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
