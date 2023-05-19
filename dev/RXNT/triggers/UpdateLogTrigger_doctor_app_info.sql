SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[UpdateLogTrigger_doctor_app_info] 
   ON  [dbo].[doctor_app_info] 
   FOR INSERT, UPDATE
 AS
    declare
    @table_name nvarchar(200),  
    @dr_id int
    
BEGIN
    SET NOCOUNT ON;
    
    -- UPDATE statements for trigger here
    SELECT @dr_id=i.dr_id FROM inserted i;   
      
    SET @table_name='dbo.doctor_app_info';      
    
    EXEC [dbo].[InsertUpdateLog] @table_name,@dr_id
    
    PRINT 'Trigger fired on doc_token_info table.'
    
END


/****** Object:  Trigger [dbo].[UpdateLogTrigger_Doctor_specialities_xref]    Script Date: 06/25/2015 10:51:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[UpdateLogTrigger_doctor_app_info] ON [dbo].[doctor_app_info]
GO

GO
