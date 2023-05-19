SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: January 12 2018
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[CheckPrescriptionApprovedStatus] 
	@PrescriptionId INT,
	@IsSuccess BIT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT TOP 1 1 FROM prescriptions WHERE pres_id=@PrescriptionId AND pres_approved_date IS NULL)
	BEGIN 
		SET @IsSuccess=0;
	END
	ELSE 
	BEGIN
		SET @IsSuccess=1;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
