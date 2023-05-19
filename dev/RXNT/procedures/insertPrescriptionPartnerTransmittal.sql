SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE insertPrescriptionPartnerTransmittal
  @PDID INTEGER,@PrescType TINYINT, @partner_id INTEGER,@QueuedDate DATETIME = NULL
AS

  IF @QueuedDate IS NULL
    BEGIN
      SET @QueuedDate = GETDATE()
    END
  /* INSERT INTO PARTNER TRANSMITTALS IF NOT ALREADY PUT */
  IF NOT EXISTS (SELECT pt_id FROM prescription_partner_transmittals WHERE pd_id = @PDID)
    BEGIN           
	INSERT INTO prescription_partner_transmittals (pd_id, pres_id, queued_date,prescription_type,partner_id)
	  SELECT @PDID, pres_id, @QueuedDate,@PrescType,@partner_id  FROM prescription_details WHERE pd_id = @PDID
    END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
