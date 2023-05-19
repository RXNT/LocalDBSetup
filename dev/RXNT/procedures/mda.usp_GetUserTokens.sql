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
CREATE PROCEDURE [mda].[usp_GetUserTokens]
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
	DECLARE @State AS VARCHAR(2) 
	IF @DoctorCompanyId = -1
	BEGIN
		SELECT TOP 1 @DoctorCompanyId = dc.dc_id 
		FROM doc_companies		DC WITH(NOLOCK) 
		INNER JOIN doc_groups	DG WITH(NOLOCK) ON DC.dc_id = DG.dc_id
		INNER JOIN doctors		DR WITH(NOLOCK) ON DG.dg_id = DR.dg_id
	END
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
	INNER JOIN	[mda].[AppLoginTokens]	ALT		WITH(NOLOCK) ON ALT.AppLogInId		= AL.dr_id
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
		    UPDATE [mda].[AppLoginTokens]
			SET	[TokenExpiryDate]	=	DATEADD(SS, @ExpirySeconds, @ExpiryDate),
				[ModifiedDate]		=	GETDATE(),
				[ModifiedBy]		=	AppLoginId
			WHERE [AppLoginTokenId] = @AppLoginTokenId AND
				  DoctorCompanyId = @DoctorCompanyId
			UPDATE @ActiveTokenInfo
			SET TokenExpiryDate = DATEADD(SS, @ExpirySeconds, @ExpiryDate)
		END
	END
	SELECT @State = A.dr_state 
	FROM @ActiveTokenInfo AT
	INNER JOIN [doctors] A WITH(NOLOCK) ON AT.AppLoginId = A.dr_id
	WHERE A.prescribing_authority>2 AND LEN(A.dr_state)>1
	 
	IF LEN(@State)<=0
	BEGIN
		SELECT @State = D.dr_state 
		FROM @ActiveTokenInfo AT
		INNER JOIN [doctors] A WITH(NOLOCK) ON AT.AppLoginId = A.dr_id
		LEFT OUTER JOIN [doctors] D WITH(NOLOCK) ON A.dr_last_alias_dr_id = D.dr_id
	END
	
	IF LEN(@State)<=0
	BEGIN
	
		SELECT TOP 1 @State = D.dr_state 
		FROM @ActiveTokenInfo AT
		INNER JOIN [doctors] A WITH(NOLOCK) ON AT.AppLoginId = A.dr_id
		LEFT OUTER JOIN [doctors] D WITH(NOLOCK) ON A.dg_id = D.dg_id
		WHERE D.dr_enabled = 1 AND D.prescribing_authority>2 AND LEN(d.dr_state)>1
	END
	
	 
	SELECT AppLoginTokenId, 
		   Token, 
		   TokenExpiryDate, 
		   AppLoginId,
		   @State AS State
	FROM @ActiveTokenInfo
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
