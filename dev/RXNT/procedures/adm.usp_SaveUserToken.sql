SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	04-Apr-2015
Description			:	This procedure is used to save user token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [adm].[usp_SaveUserToken]
(
	@AppLoginId			BIGINT,
	@DoctorCompanyId	BIGINT,
	@Token				VARCHAR(900),
	@ExpirySeconds		INT	
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @TokenExpiryDate DATETIME2;
	SET @TokenExpiryDate = DATEADD(SS, @ExpirySeconds, GETDATE());
	INSERT INTO [adm].[AppLoginTokens]
           ([AppLoginId]
           ,[DoctorCompanyId]
           ,[Token]
           ,[TokenExpiryDate]
           ,[CreatedDate]
           ,[CreatedBy])
     VALUES
           (@AppLoginId
           ,@DoctorCompanyId
           ,@Token
           ,@TokenExpiryDate
           ,GETDATE()
           ,@AppLoginId)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
