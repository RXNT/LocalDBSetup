SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [eRx2019].[SavePrescriptionVoidTransmittal]
  @RxId INTEGER, @DeliveryMethod INTEGER = NULL,
  @QueuedDate DATETIME = NULL
AS
  IF @DeliveryMethod IS NULL
    BEGIN
      SELECT @DeliveryMethod = pres_delivery_method FROM prescriptions WITH(NOLOCK) WHERE pres_id = @RxId
    END
  IF (@DeliveryMethod & 0xFFFF0000) <> 0
    BEGIN
      IF NOT EXISTS (SELECT pres_id FROM prescription_void_transmittals WITH(NOLOCK) WHERE pres_id = @RxId)
	BEGIN
	  IF @QueuedDate IS NULL
	    BEGIN
	      SET @QueuedDate = GETDATE()
	    END
	  INSERT INTO prescription_void_transmittals (refreq_id, pres_id, pd_id, queued_date, delivery_method)
	    SELECT refreq_id, A.pres_id, pd_id, @QueuedDate, pres_delivery_method & 0xFFFF0000 FROM prescriptions A WITH(NOLOCK),
	      refill_requests B WITH(NOLOCK), prescription_details C WITH(NOLOCK) WHERE A.pres_id = B.pres_id AND A.pres_id = C.pres_id
	      AND A.pres_id = @RxId
	END
    ELSE
    BEGIN
		UPDATE PRESCRIPTIONS SET PRES_VOID = PRES_VOID WHERE pres_id = @RxId
	END	
    END
    ELSE
    BEGIN
		UPDATE PRESCRIPTIONS SET PRES_VOID = PRES_VOID WHERE pres_id = @RxId
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
