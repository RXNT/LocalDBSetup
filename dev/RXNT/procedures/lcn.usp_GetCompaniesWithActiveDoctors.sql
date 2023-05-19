SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Nambi 
Create date			: 19-June-2019
Description			: To Get Companies With Active Doctors
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [lcn].[usp_GetCompaniesWithActiveDoctors]
AS 
BEGIN 
	SET NOCOUNT ON; 
	SELECT DISTINCT DC.dc_id AS DoctorCompanyId, DC.dc_name AS DoctorCompanyName
	FROM dbo.[doc_companies] DC WITH(NOLOCK)
	INNER JOIN dbo.[doc_groups] DG WITH(NOLOCK) ON DC.dc_id=DG.dc_id
	INNER JOIN dbo.[doctors] DR WITH(NOLOCK) ON DG.dg_id=DR.dg_id
	WHERE DR.dr_enabled=1
	ORDER BY DC.dc_id ASC, DC.dc_name ASC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
