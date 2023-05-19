SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Vinod
-- Create date:  Dec 13, 2016
-- Description:	 Accept All Patient Lab Order
-- =============================================
CREATE PROCEDURE [support].[DoctorGroupAcceptAllLabResults]
(
	@DoctorGroupId BIGINT 
)
AS
BEGIN
	UPDATE dbo.lab_main SET IS_READ = 1, READ_BY = dr_id WHERE dg_id = @DoctorGroupId and ISNULL(is_read,0) = 0
END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
