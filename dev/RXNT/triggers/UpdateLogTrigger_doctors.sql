SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[UpdateLogTrigger_doctors] 
   ON  [dbo].[doctors] 
   FOR INSERT, UPDATE
 AS
    declare
    @table_name nvarchar(200),  
    @dr_id int
    
BEGIN
    SET NOCOUNT ON;
    
    -- UPDATE statements for trigger here
    SELECT @dr_id=i.dr_id FROM inserted i;   
      
    SET @table_name='dbo.doctors';
    DECLARE @Cinfo VARBINARY(128) 
	SELECT @Cinfo = Context_Info() 
	IF @Cinfo = 0x55555 
		RETURN 
	EXEC [dbo].[InsertUpdateLog] @table_name,@dr_id
    PRINT 'Trigger fired ON doctors table.'
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[UpdateLogTrigger_doctors] ON [dbo].[doctors]
GO

GO
