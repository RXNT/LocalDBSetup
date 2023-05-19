SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER tr_prescription_details_after_insert
ON dbo.prescription_details
AFTER INSERT
AS
  DECLARE @sgStatus AS TINYINT,
    @sgID AS INTEGER
  SELECT @sgStatus = script_guide_status, @sgID = script_guide_id FROM inserted
  IF @sgStatus IS NOT NULL
    BEGIN
      IF @sgStatus = 1
	UPDATE ScriptGuideProgramSpecifications SET test_count = test_count + 1 WHERE sg_id = @sgID
      ELSE
	UPDATE ScriptGuideProgramSpecifications SET control_count = control_count + 1 WHERE sg_id = @sgID
    END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_prescription_details_after_insert] ON [dbo].[prescription_details]
GO

GO
