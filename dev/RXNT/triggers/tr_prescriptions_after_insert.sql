SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[tr_prescriptions_after_insert]
ON [dbo].[prescriptions]
AFTER INSERT
AS
  DECLARE @PatId AS INTEGER, @PharmId AS INTEGER, @PresDate AS DATETIME
  SELECT @PatId = pa_id, @PharmId = pharm_id, @PresDate = pres_entry_date FROM inserted
  IF (@PatId <> 0) AND (@PharmId <> 0)
    IF NOT EXISTS (SELECT * FROM patients_fav_pharms WHERE pa_id = @PatId AND pharm_id = @PharmId)
	BEGIN
		BEGIN TRY
		  INSERT INTO patients_fav_pharms VALUES (@PatId, @PharmId, @PresDate)
		END TRY
		BEGIN CATCH
			PRINT ERROR_MESSAGE()
		END CATCH
	END
    ELSE
      UPDATE patients_fav_pharms SET pharm_use_date = @PresDate WHERE pa_id = @PatId AND pharm_id = @PharmId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_prescriptions_after_insert] ON [dbo].[prescriptions]
GO

GO
