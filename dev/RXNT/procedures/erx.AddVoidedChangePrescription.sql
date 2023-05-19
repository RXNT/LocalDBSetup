SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	21-SEP-2017
-- Description:		Add Voided change prescription
-- =============================================
CREATE PROCEDURE [erx].[AddVoidedChangePrescription]
  @DeliveryMethod			BIGINT,
  @PresId					BIGINT
AS
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM erx.RxChangeVoidTransmittals WHERE PresId=@PresId)
	BEGIN
		DECLARE @ChgReqId AS BIGINT= 0
		DECLARE @PdId AS BIGINT = 0
		SELECT @ChgReqId = ChgReqId FROM erx.RxChangeRequests WHERE PresId=@PresId
		SELECT @PdId=pd_id FROM prescription_details WHERE pres_id=@PresId
		IF(@ChgReqId > 0 AND @PdId > 0)
		BEGIN
			INSERT INTO erx.RxChangeVoidTransmittals (ChgReqId, Type, PresId, PdId, DeliveryMethod, QueuedDate)
			VALUES(@ChgReqId, 5, @PresId, @PdId, @DeliveryMethod, GETDATE())
		END
	END	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
