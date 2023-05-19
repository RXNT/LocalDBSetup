SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	19-Sep-2016
Description			:	This procedure is used to save user token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [aut].[usp_SaveUserAuthToken]
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
	INSERT INTO [aut].[AppLoginTokens]
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
