SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 15-SEP-2017
-- Description:	To get the new rx message id
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadNewRxMessageId]
	@PresId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1 pt_id FROM prescription_transmittals WITH(NOLOCK) WHERE PRES_ID= @PresId ORDER BY response_date DESC
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
