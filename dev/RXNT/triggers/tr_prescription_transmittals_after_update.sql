SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER tr_prescription_transmittals_after_update
ON prescription_transmittals
AFTER UPDATE
AS
  IF UPDATE(response_date)
    BEGIN
      UPDATE prescription_status SET response_type = B.response_type, response_date = B.response_date, response_text = B.response_text,
        confirmation_id = B.confirmation_id FROM prescription_status A, inserted B WHERE A.pd_id = B.pd_id AND A.delivery_method = B.delivery_method
    END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

DISABLE TRIGGER [dbo].[tr_prescription_transmittals_after_update] ON [dbo].[prescription_transmittals]
GO

GO
