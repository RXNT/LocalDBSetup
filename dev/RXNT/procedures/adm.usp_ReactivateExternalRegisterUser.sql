SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Kanniyappan
Create date			:	27-Sep-2016
Description			:	This procedure is used to reactive App Login Filtered on Doctor Company Id
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [adm].[usp_ReactivateExternalRegisterUser]	
	@ExternalLoginId	BIGINT,
	@ExternalCompanyId	BIGINT,
	@ConcurrencyErr		BIT OUTPUT
AS
	SET @ConcurrencyErr = 0;

	IF NOT EXISTS(	SELECT 1 
					FROM 
					dbo.doc_companies DC with(nolock)
					INNER JOIN dbo.doc_groups DG with(nolock) ON DC.dc_id = DG.dc_id
					INNER JOIN dbo.doctors	  DR with(nolock) ON DG.dg_id = DR.dg_id
					WHERE	DC.dc_id = @ExternalCompanyId
					AND		DR.dr_id = @ExternalLoginId)			  
					
	BEGIN
		SET @ConcurrencyErr = 1;
	END
	
	IF @ConcurrencyErr = 0
	BEGIN		
		UPDATE	[dbo].[doctors]
		SET		dr_enabled			= 1, 
				activated_date		= GETDATE()
		WHERE	dr_id				= @ExternalLoginId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
