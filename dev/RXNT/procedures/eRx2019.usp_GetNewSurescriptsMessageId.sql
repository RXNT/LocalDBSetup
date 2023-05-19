SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_GetNewSurescriptsMessageId] 
@DoctorId BIGINT=0,
@MessageType INT

AS
BEGIN
    SET NOCOUNT ON 
	INSERT INTO [surescript_admin_message]
	([messageid],[message_type],[dr_id])
	VALUES ('',@MessageType,@MessageType)
	SELECT SCOPE_IDENTITY()
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
