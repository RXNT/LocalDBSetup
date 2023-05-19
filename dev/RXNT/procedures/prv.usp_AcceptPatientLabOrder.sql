SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Nambi
-- Create date:  Sep 26, 2016
-- Description:	 Accept Patient Lab Order
-- =============================================
CREATE PROCEDURE [prv].[usp_AcceptPatientLabOrder]
(
	@LabId BIGINT,
	@LoggedInUserId BIGINT
)
AS
BEGIN
	UPDATE dbo.lab_main SET IS_READ = 1, READ_BY = @LoggedInUserId WHERE LAB_ID = @LABID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
