SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To get the pharmacy request message
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadPharmacyRequestMessage]
	@PresId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT fullRequestMessage FROM REFILL_REQUESTS WHERE PRES_ID= @PresId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
