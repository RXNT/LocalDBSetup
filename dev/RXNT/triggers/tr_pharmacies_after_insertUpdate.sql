SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER tr_pharmacies_after_insertUpdate
ON dbo.pharmacies
AFTER INSERT, UPDATE
AS
  DECLARE @PharmId As INTEGER, @pending AS BIT, @enabled AS BIT, @city AS VARCHAR(80), @state AS VARCHAR(2)
  SELECT @PharmId = pharm_id, @pending = pharm_pending_addition, @enabled = pharm_enabled, @city = pharm_city, @state = pharm_state FROM inserted
  IF (@enabled <> 0) AND (@pending = 0)
    BEGIN
--      IF UPDATE(pharm_company_name) OR UPDATE(pharm_city) OR UPDATE(pharm_state) OR UPDATE(pharm_zip) OR UPDATE(pharm_phone)
      UPDATE doc_fav_pharms SET update_code = 10 WHERE pharm_id = @PharmId AND update_code = 0
      INSERT INTO doc_fav_pharms (dr_id, pharm_id, update_code) SELECT dr_id, @PharmId, 10 FROM doc_fav_cities WHERE fc_city = @city AND fc_state = @state
             AND NOT EXISTS (SELECT * FROM doc_fav_pharms WHERE dr_id = doc_fav_cities.dr_id AND pharm_id = @PharmId)
    END
  ELSE
      UPDATE doc_fav_pharms SET update_code = 100 WHERE pharm_id = @PharmId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_pharmacies_after_insertUpdate] ON [dbo].[pharmacies]
GO

GO
