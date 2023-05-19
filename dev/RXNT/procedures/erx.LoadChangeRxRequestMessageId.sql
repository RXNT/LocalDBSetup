SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	20-SEP-2017
-- Description:		Get Change Rx Request Message Id
-- =============================================
CREATE PROCEDURE [erx].[LoadChangeRxRequestMessageId]
  @PresId					BIGINT
AS
BEGIN
	SELECT TOP 1 MessageId FROM erx.RxChangeRequests WHERE PresId=@PresId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
