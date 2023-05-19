SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	KANNIYAPPAN NARASIMAN
Create date			:	27-JUN-2016
Description			:	This procedure is used to update the dashboard user email after verify
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [adm].[usp_VerifyDashboardUserEmailAdminV1]
(
	@Username		VARCHAR(100),
	@Email			VARCHAR(100),
	@ConcurrencyErr	BIT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SET @ConcurrencyErr = 0;
	
	IF ISNULL(@Username,'0') <> '0' 
	BEGIN
			IF NOT EXISTS(SELECT NULL FROM [dbo].[doctors]
						WHERE dr_Username = @Username)
		BEGIN
			SET @ConcurrencyErr = 1;
		END
	END
	
	IF @ConcurrencyErr = 0
	BEGIN
			
	 	UPDATE [dbo].[doctors]
		SET    dr_email		   = @Email,
			   isEmailverified = 1,
			   IsEmailVerificationPending = 0 
		WHERE  dr_Username	= @Username
				  
	END
  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
