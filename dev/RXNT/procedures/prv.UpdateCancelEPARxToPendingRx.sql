SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 22-Dec-2021
-- Description:	Release the EPA link with the prescription
-- =============================================
CREATE PROCEDURE [prv].[UpdateCancelEPARxToPendingRx] 
	@RxId BIGINT,
	@RxDetailId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE prescription_details
	SET hide_on_pending_rx=0,prior_authorization_status=NULL,prior_auth_number=NULL,PAReferenceId=NULL
	WHERE pd_id=@RxDetailId AND pres_id=@RxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
