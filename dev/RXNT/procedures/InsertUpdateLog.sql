SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[InsertUpdateLog]
  @table_name VARCHAR(200),
  @dr_id INTEGER  
AS  
  BEGIN
	DECLARE @Cinfo VARBINARY(128) 
	SELECT @Cinfo = Context_Info() 

	--IF @dr_id < 0 And @Cinfo <> 0x55555
	IF @dr_id > 0
	BEGIN
		INSERT INTO [dbo].[insert_update_log] (Table_Name, DrID, UpdatedDate) VALUES(@table_name, @dr_id, GETDATE())
	END
  END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
