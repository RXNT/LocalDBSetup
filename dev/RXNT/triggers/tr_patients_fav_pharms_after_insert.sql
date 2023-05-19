SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[tr_patients_fav_pharms_after_insert]
ON [dbo].[patients_fav_pharms]
AFTER INSERT
AS
  DECLARE @PatId AS INTEGER
  SELECT @PatId = pa_id FROM inserted
  UPDATE fav_patients SET pharm_update_code = 10 WHERE pa_id = @PatId AND update_code = 0
  IF EXISTS (SELECT COUNT(*) FROM patients_fav_pharms WHERE pa_id = @PatId HAVING COUNT(*) > 5)
    DELETE FROM patients_fav_pharms WHERE pa_id = @PatId AND pharm_use_date = (SELECT MIN(pharm_use_date) FROM patients_fav_pharms WHERE pa_id = @PatId)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

DISABLE TRIGGER [dbo].[tr_patients_fav_pharms_after_insert] ON [dbo].[patients_fav_pharms]
GO

GO
