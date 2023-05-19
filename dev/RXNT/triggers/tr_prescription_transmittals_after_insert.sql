SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[tr_prescription_transmittals_after_insert]
ON [dbo].[prescription_transmittals]
AFTER INSERT
AS
  UPDATE prescription_status SET queued_date = inserted.queued_date, response_type = NULL, response_date = NULL, response_text = NULL, confirmation_id = NULL
    FROM prescription_status, inserted WHERE prescription_status.pd_id = inserted.pd_id AND prescription_status.delivery_method = inserted.delivery_method
  INSERT INTO prescription_status (pd_id, delivery_method, queued_date, response_type, response_date, response_text, confirmation_id)
    SELECT pd_id, delivery_method, queued_date, response_type, response_date, response_text, confirmation_id FROM inserted WHERE NOT EXISTS
      (SELECT ps_id FROM prescription_status WHERE pd_id = inserted.pd_id AND delivery_method = inserted.delivery_method)
  UPDATE prescription_transmittals SET pres_id = B.pres_id FROM prescription_transmittals A, prescription_details B, inserted C 
    WHERE A.pt_id = C.pt_id AND A.pd_id = B.pd_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_prescription_transmittals_after_insert] ON [dbo].[prescription_transmittals]
GO

GO
