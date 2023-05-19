SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: KANNIYAPPAN NARASIMAN
-- Create date	: 20-Jun-2016
-- Description	: to update valid zipcode 
-- =============================================

CREATE PROCEDURE [adm].[usp_UpdateValidZipcode]
(
	@DocotorId					BIGINT,
	@GroupId					BIGINT,
	@CityId						VARCHAR(50),
	@StateId					VARCHAR(30),
	@ZipCode					VARCHAR(20),
	@ConcurrencyErr				BIT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	SET @ConcurrencyErr = 0;
	BEGIN
		IF NOT EXISTS(	SELECT 1 FROM dbo.doctors 
						WHERE dr_id	= @DocotorId
					  )
		BEGIN
		  SET @ConcurrencyErr = 1;
		END
		
		IF @ConcurrencyErr = 0
		 BEGIN
			
			UPDATE dbo.doctors	
			SET
				      dr_city		= @CityId,
				      dr_state		= @StateId,
					  dr_zip		= @ZipCode
			WHERE	  dr_id			= @DocotorId
	      END
	
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
