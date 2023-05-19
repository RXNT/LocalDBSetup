SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 
CREATE PROCEDURE [aut].[usp_GetUserTokens] 
(
	@DoctorCompanyId	BIGINT,
	@Signature			VARCHAR(900),
	@Token				VARCHAR(900) = NULL,
	@ExpirySeconds		INT,
	@ExtendBefore		INT,
	@IsV2TokenActive	BIT = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	--Extend Token Life Time
	DECLARE @AppLoginTokenId BIGINT,
			@ExpiryDate DATETIME2;			

		IF(ISNULL(@IsV2TokenActive, 0) = 1) -- Extending the token when the V2 token is active
			BEGIN
				SELECT TOP 1 @AppLoginTokenId = [AppLoginTokenId],@ExpiryDate = TokenExpiryDate
				FROM [aut].[AppLoginTokens] ALT	WITH(NOLOCK)
				WHERE	ALT.DoctorCompanyId = @DoctorCompanyId AND 
					ALT.[Token] = @Token  

				IF(@AppLoginTokenId>0)
				BEGIN	
					if(@ExpiryDate < GETDATE())
						UPDATE [aut].[AppLoginTokens]
						SET	[TokenExpiryDate]	=	DATEADD(SS, @ExpirySeconds, GETDATE()),
							[ModifiedDate]		=	GETDATE(),
							[ModifiedBy]		=	AppLoginId
						WHERE [AppLoginTokenId] = @AppLoginTokenId AND
								DoctorCompanyId = @DoctorCompanyId					
				END
			END			 
		ELSE
			BEGIN
				SELECT TOP 1 @AppLoginTokenId = [AppLoginTokenId],@ExpiryDate = TokenExpiryDate
				FROM [aut].[AppLoginTokens] ALT	WITH(NOLOCK)
				WHERE	ALT.DoctorCompanyId = @DoctorCompanyId AND 
					ALT.[Token] = @Token AND
					ALT.[TokenExpiryDate] > GETDATE()

				IF(@AppLoginTokenId>0)
					BEGIN
						DECLARE @RemainingSecondsBeforeExpiry INT
			
						SET @RemainingSecondsBeforeExpiry = DATEDIFF(SS, GETDATE(), @ExpiryDate);
						IF(@RemainingSecondsBeforeExpiry <= @ExtendBefore)
						BEGIN
							UPDATE [aut].[AppLoginTokens]
							SET	[TokenExpiryDate]	=	DATEADD(SS, @ExpirySeconds, @ExpiryDate),
								[ModifiedDate]		=	GETDATE(),
								[ModifiedBy]		=	AppLoginId
							WHERE [AppLoginTokenId] = @AppLoginTokenId AND
									DoctorCompanyId = @DoctorCompanyId
						END	
					END
			END
	SELECT TOP 1 ALT.[AppLoginTokenId],
	   ALT.[Token],
	   ALT.[TokenExpiryDate],
	   AL.dr_id As AppLoginId
	FROM [doctors] AL					WITH(NOLOCK)
	INNER JOIN	[doc_groups] DG	WITH(NOLOCK) ON AL.dg_id	= DG.dg_id
	INNER JOIN	[doc_companies] DCMP	WITH(NOLOCK) ON DG.dc_id = DCMP.dc_id 
	INNER JOIN	[aut].[AppLoginTokens]	ALT		WITH(NOLOCK) ON ALT.AppLogInId		= AL.dr_id
	WHERE ALT.AppLoginTokenId = @AppLoginTokenId AND
		  DCMP.dc_id = @DoctorCompanyId	AND 
		  ALT.[Token] = @Token AND
		  ALT.[TokenExpiryDate] > GETDATE()
		
END
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
