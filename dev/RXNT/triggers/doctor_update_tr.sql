SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE    TRIGGER [dbo].[doctor_update_tr]
on [dbo].[doctors]
AFTER UPDATE
AS 
  DECLARE @DR AS INTEGER
  DECLARE @ENABLED_New AS bit
  DECLARE @prescribing_authority AS INTEGER
  SELECT @DR = dr_id,@ENABLED_New = dr_enabled ,@prescribing_authority = prescribing_authority 
  FROM inserted
  

IF  update(dr_enabled)  
BEGIN
	EXEC [dbo].[InsertUpdateLog] 'dbo.doctors',@DR
 INSERT into doctors_status_log select U.dr_id, getdate(), SYSTEM_USER from DELETED U
 DECLARE @ENABLED_Old AS bit
 SELECT @ENABLED_Old = dr_enabled FROM DELETED U
 IF @ENABLED_New=0 AND ISNULL(@ENABLED_Old,0)=1
 BEGIN
   UPDATE doctors SET deactivated_date = GETDATE() WHERE dr_id = @DR
 End
 IF @prescribing_authority IN (3,4) AND ISNULL(@ENABLED_Old,0)=0 AND @ENABLED_New=1
 BEGIN
	INSERT into doctors_reactivated_status_log select U.dr_id, getdate(), SYSTEM_USER from DELETED U
 END
End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[doctor_update_tr] ON [dbo].[doctors]
GO

GO
