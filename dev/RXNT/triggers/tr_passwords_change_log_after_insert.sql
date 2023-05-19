SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  TRIGGER [dbo].[tr_passwords_change_log_after_insert]
ON [dbo].[passwords_change_log]
AFTER INSERT
AS
  DECLARE @drID INT, @recCount INT, @delCount INT
  SELECT @drID = dr_id FROM inserted
  SELECT @recCount = COUNT(1) FROM passwords_change_log WHERE dr_id = @drID
  IF @recCount > 7
    BEGIN
      SET @delCount = @recCount - 7
      EXEC('DELETE FROM passwords_change_log WHERE pcl_id IN (SELECT TOP ' + @delCount + ' pcl_id
        FROM passwords_change_log WHERE dr_id = ' + @drID + ' ORDER BY password_create_date ASC)')
    END
  UPDATE doctors SET password_expiry_date = DATEADD(MONTH, 3, GETDATE()) WHERE dr_id=@drID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_passwords_change_log_after_insert] ON [dbo].[passwords_change_log]
GO

GO
