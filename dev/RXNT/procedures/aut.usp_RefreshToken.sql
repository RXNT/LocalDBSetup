SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Singaravvelan
Create date			:	27-Jan-2017
Description			:	This procedure is used to get user tokens by signature/token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [aut].[usp_RefreshToken]
(
	@DoctorCompanyId	BIGINT,
	@Signature			VARCHAR(900),
	@Token				VARCHAR(900) = NULL,
	@ExpirySeconds		INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--Extend Token Life Time
	DECLARE @AppLoginTokenId BIGINT,
			@ExpiryDate DATETIME2;
				
	SELECT TOP 1 @AppLoginTokenId = [AppLoginTokenId],
				 @ExpiryDate = TokenExpiryDate
	FROM [aut].[AppLoginTokens] ALT	WITH(NOLOCK)
	WHERE	ALT.DoctorCompanyId = @DoctorCompanyId AND 
			ALT.[Token] = @Token AND
			ALT.[TokenExpiryDate] > GETDATE()
		  
	IF(@AppLoginTokenId>0)
	BEGIN
		    UPDATE [aut].[AppLoginTokens]
			SET	[TokenExpiryDate]	=	DATEADD(SS, @ExpirySeconds, GETDATE()),
				[ModifiedDate]		=	GETDATE(),
				[ModifiedBy]		=	AppLoginId
			WHERE [AppLoginTokenId] = @AppLoginTokenId AND
				  DoctorCompanyId = @DoctorCompanyId
	
	END
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
