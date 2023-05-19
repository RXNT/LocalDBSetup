SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To get the refill denied message id
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadRefillDeniedMessageId]
	@PresId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1 pvt_id FROM prescription_void_transmittals WITH(NOLOCK) WHERE PRES_ID= @PresId ORDER BY response_date DESC
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
