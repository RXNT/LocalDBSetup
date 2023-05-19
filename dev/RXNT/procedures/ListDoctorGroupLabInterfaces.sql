SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--==========================================
-- Author:		Nambi
-- Create date: 18-MAY-2018
-- Description:	List Doctor Group Lab Interfaces
-- =============================================

CREATE PROCEDURE [dbo].[ListDoctorGroupLabInterfaces]
	@DoctorGroupId BIGINT
AS
BEGIN
	SELECT doc_group_lab_xref_id, name, auto_read_lab_result FROM doc_groups_lab_info WHERE dg_id=@DoctorGroupId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
