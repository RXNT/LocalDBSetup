SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	03-Apr-201
Description			:	This procedure is used to get user tokens by signature/token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [enc].[usp_GetUserTokens]
(
	@DoctorCompanyId	BIGINT,
	@Signature			VARCHAR(900),
	@Token				VARCHAR(900) = NULL,
	@ExpirySeconds		INT,
	@ExtendBefore		INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--IF @DoctorCompanyId = -1
	--BEGIN
	--	SELECT TOP 1 @DoctorCompanyId = dc.dc_id 
	--	FROM doc_companies		DC WITH(NOLOCK) 
	--	INNER JOIN doc_groups	DG WITH(NOLOCK) ON DC.dc_id = DG.dc_id
	--	INNER JOIN doctors		DR WITH(NOLOCK) ON DG.dg_id = DR.dg_id
	--END
	DECLARE @ActiveTokenInfo AS TABLE (AppLoginTokenId BIGINT, Token VARCHAR(900), 
											TokenExpiryDate DATETIME2, AppLoginId BIGINT);
	
	--GET Active Token
	INSERT INTO @ActiveTokenInfo(AppLoginTokenId, Token, TokenExpiryDate, AppLoginId)
	SELECT ALT.[AppLoginTokenId],
	   ALT.[Token],
	   ALT.[TokenExpiryDate],
	   AL.dr_id As AppLoginId
	FROM [doctors] AL					WITH(NOLOCK)
	INNER JOIN	[doc_groups] DG	WITH(NOLOCK) ON AL.dg_id	= DG.dg_id
	INNER JOIN	[doc_companies] DCMP	WITH(NOLOCK) ON DG.dc_id = DCMP.dc_id 
	INNER JOIN	[enc].[AppLoginTokens]	ALT		WITH(NOLOCK) ON ALT.AppLogInId		= AL.dr_id
	WHERE DCMP.dc_id = @DoctorCompanyId	AND
		  --ALI.[Signature] = @Signature			AND 
		  ALT.[Token] = @Token AND
		  ALT.[TokenExpiryDate] > GETDATE()
	
	--Extend Token Life Time
	IF EXISTS(SELECT 1 FROM @ActiveTokenInfo)
	BEGIN
		DECLARE @RemainingSecondsBeforeExpiry INT,
				@AppLoginTokenId BIGINT,
				@ExpiryDate DATETIME2;
				
		SELECT @ExpiryDate = TokenExpiryDate, 
			   @AppLoginTokenId = [AppLoginTokenId]
		FROM @ActiveTokenInfo
		
		SET @RemainingSecondsBeforeExpiry = DATEDIFF(SS, GETDATE(), @ExpiryDate);
		IF(@RemainingSecondsBeforeExpiry <= @ExtendBefore)
		BEGIN
		    UPDATE [enc].[AppLoginTokens]
			SET	[TokenExpiryDate]	=	DATEADD(SS, @ExpirySeconds, @ExpiryDate),
				[ModifiedDate]		=	GETDATE(),
				[ModifiedBy]		=	AppLoginId
			WHERE [AppLoginTokenId] = @AppLoginTokenId AND
				  DoctorCompanyId = @DoctorCompanyId
			UPDATE @ActiveTokenInfo
			SET TokenExpiryDate = DATEADD(SS, @ExpirySeconds, @ExpiryDate)
		END
	END
	
	SELECT AppLoginTokenId, 
		   Token, 
		   TokenExpiryDate, 
		   AppLoginId 
	FROM @ActiveTokenInfo
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
