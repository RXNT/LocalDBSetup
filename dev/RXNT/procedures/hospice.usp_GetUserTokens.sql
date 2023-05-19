SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
author				:	Nambi
Create date			:	02-May-2018
Description			:	This procedure is used to get partner tokens by signature/token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [hospice].[usp_GetUserTokens]
(
	@PartnerId			BIGINT,
	@Signature			VARCHAR(900),
	@Token				VARCHAR(900) = NULL,
	@ExpirySeconds		INT,
	@ExtendBefore		INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--Extend Token Life Time
	DECLARE @AppLoginTokenId BIGINT,
			@ExpiryDate DATETIME2;
				
	SELECT TOP 1 @AppLoginTokenId = [AppLoginTokenId],
				 @ExpiryDate = TokenExpiryDate
	FROM [hospice].[AppLoginTokens] ALT	WITH(NOLOCK)
	WHERE	ALT.PartnerId = @PartnerId AND 
			ALT.[Token] = @Token AND
			ALT.[TokenExpiryDate] > GETDATE()
		  
	IF(@AppLoginTokenId>0)
	BEGIN
		DECLARE @RemainingSecondsBeforeExpiry INT
			
	    SET @RemainingSecondsBeforeExpiry = DATEDIFF(SS, GETDATE(), @ExpiryDate);
		IF(@RemainingSecondsBeforeExpiry <= @ExtendBefore)
		BEGIN
		    UPDATE [hospice].[AppLoginTokens]
			SET	[TokenExpiryDate]	=	DATEADD(SS, @ExpirySeconds, @ExpiryDate),
				[ModifiedDate]		=	GETDATE(),
				[ModifiedBy]		=	PartnerId
			WHERE [AppLoginTokenId] = @AppLoginTokenId AND
				  PartnerId = @PartnerId
		END
	
	END
	
	
	SELECT TOP 1 ALT.[AppLoginTokenId],
	   ALT.[Token],
	   ALT.[TokenExpiryDate],
	   ALT.PartnerId AS AppLoginId
	FROM [hospice].[AppLoginTokens]	ALT		WITH(NOLOCK)
	INNER JOIN partner_accounts PA WITH(NOLOCK) ON ALT.PartnerId=pa.PARTNER_ID
	WHERE ALT.AppLoginTokenId = @AppLoginTokenId AND
		  pa.PARTNER_ID = @PartnerId	AND 
		  ALT.[Token] = @Token AND
		  ALT.[TokenExpiryDate] > GETDATE()
	
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
