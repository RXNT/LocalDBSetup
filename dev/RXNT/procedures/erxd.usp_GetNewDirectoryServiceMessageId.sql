SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [erxd].[usp_GetNewDirectoryServiceMessageId] 
    @message_type            VARCHAR(20),
    @dr_id    INT 
AS
BEGIN
	DECLARE @message_Id INT
    SET NOCOUNT ON

    INSERT INTO [surescript_admin_message]([messageid],[message_type],[dr_id]) 
                        VALUES ('',@message_type,@dr_id)

    SELECT @message_Id = SCOPE_IDENTITY()

    SELECT @message_Id AS id

    RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
