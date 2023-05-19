SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
           

CREATE PROCEDURE [erxd].[usp_UpadteDirectoryServiceMessageId] 
    @message_id  VARCHAR(200),
    @response_type    bit,
    @response_text VARCHAR(200),
    @send_date Datetime,
    @response_date Datetime, 

    @message_type BIGINT,
    @id BIGINT
AS
BEGIN
    SET NOCOUNT ON
    Update [dbo].[surescript_admin_message] SET [messageid] = @message_id,response_type =@response_type,
		response_text = @response_text, send_date = @send_date,response_date = @response_date,
		message_type= @message_type WHERE ID=@id
		
		END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
