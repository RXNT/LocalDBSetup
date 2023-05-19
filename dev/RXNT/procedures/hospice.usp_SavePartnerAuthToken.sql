SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Nambi
Create date			:	02-May-2018
Description			:	This procedure is used to save partner token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [hospice].[usp_SavePartnerAuthToken]
(
	@PartnerId	BIGINT,
	@Token				VARCHAR(900),
	@ExpirySeconds		INT	
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @TokenExpiryDate DATETIME2;
	SET @TokenExpiryDate = DATEADD(SS, @ExpirySeconds, GETDATE());
	INSERT INTO [hospice].[AppLoginTokens]
           ([PartnerId]
           ,[Token]
           ,[TokenExpiryDate]
           ,[CreatedDate]
           ,[CreatedBy]
		   ,Active)
     VALUES
           (@PartnerId
           ,@Token
           ,@TokenExpiryDate
           ,GETDATE()
           ,@PartnerId
		   ,1)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
