SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Ramakrishna
-- Create date: 	24-Nov-2016
-- Description:		
-- =============================================
CREATE PROCEDURE [dbo].[SearchDrugSigRoutes]

	@DoctorGroupId		INT

AS
BEGIN
		SELECT dg_drug_route_id,code,description FROM doc_group_drug_route WHERE dg_id=@DoctorGroupId 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
