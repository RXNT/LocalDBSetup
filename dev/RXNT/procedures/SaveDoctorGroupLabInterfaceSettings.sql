SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 18-MAY-2018
-- Description:	Save Doctor Group Lab Interface Settings
-- =============================================

CREATE PROCEDURE [dbo].[SaveDoctorGroupLabInterfaceSettings]
	@DoctorGroupId BIGINT,
	@InterfaceId BIGINT,
	@AutoReadLabResult BIGINT
AS
BEGIN
	UPDATE doc_groups_lab_info SET auto_read_lab_result=@AutoReadLabResult WHERE dg_id=@DoctorGroupId AND doc_group_lab_xref_id=@InterfaceId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
