SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description:	Get Patient Tokens
-- =============================================
CREATE PROCEDURE  [phr].[usp_GetPatientTokens]
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
	
	DECLARE @ActiveTokenInfo AS TABLE (AppLoginTokenId BIGINT, Token VARCHAR(900), 
											TokenExpiryDate DATETIME2, AppLoginId BIGINT);
	
	--GET Active Token
	INSERT INTO @ActiveTokenInfo(AppLoginTokenId, Token, TokenExpiryDate, AppLoginId)
	SELECT ALT.[PatientTokenId],
	   ALT.[Token],
	   ALT.[TokenExpiryDate],
	   PL.pa_id As AppLoginId
	FROM dbo.[patient_login] PL					WITH(NOLOCK)
	INNER JOIN dbo.patients P ON PL.pa_id = P.pa_id 
	INNER JOIN	[doc_groups] DG	WITH(NOLOCK) ON P.dg_id	= DG.dg_id
	INNER JOIN	[doc_companies] DCMP	WITH(NOLOCK) ON DG.dc_id = DCMP.dc_id 
	INNER JOIN	[dbo].[PatientTokens]	ALT		WITH(NOLOCK) ON ALT.PatientId		= PL.pa_id
	WHERE DCMP.dc_id = @DoctorCompanyId	AND
		  PL.[Signature] = @Signature			AND 
		  ALT.[Token] = ISNULL(@Token, ALT.[Token]) AND
		  ALT.[TokenExpiryDate] > GETDATE() AND ALT.Active = 1
	
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
		    UPDATE [dbo].[PatientTokens]
			SET	[TokenExpiryDate]	=	DATEADD(SS, @ExpirySeconds, @ExpiryDate),
				[ModifiedDate]		=	GETDATE()
			WHERE [PatientTokenId] = @AppLoginTokenId AND
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
