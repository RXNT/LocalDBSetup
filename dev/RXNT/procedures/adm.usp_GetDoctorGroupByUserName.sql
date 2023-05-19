SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 18th July 2018
-- Description:	To get group details by doctor username
-- =============================================
CREATE PROCEDURE [adm].[usp_GetDoctorGroupByUserName]  
	@UserName VARCHAR(MAX)
AS

BEGIN
	SET NOCOUNT ON;
	SELECT dg.dg_id GroupId,dg.dg_name GroupName FROM doctors d 
	INNER JOIN doc_groups dg ON d.dg_id=dg.dg_id
	WHERE d.dr_username=@UserName
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
