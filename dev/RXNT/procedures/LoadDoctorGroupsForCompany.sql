SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: JULY 28, 2017
-- Description:	Load Doctor groups from company Id
-- =============================================
CREATE PROCEDURE [dbo].[LoadDoctorGroupsForCompany]
(
	-- Add parameters for the stored procedure here
	@DCID	INT
)
AS
BEGIN
	SELECT dg_id, dg_name FROM doc_groups WHERE dc_id=@DCID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
