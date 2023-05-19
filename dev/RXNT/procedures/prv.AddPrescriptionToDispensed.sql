SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	26-NOV-2017
-- Description:		Add Prescription To Dispensed
-- =============================================
CREATE PROCEDURE [prv].[AddPrescriptionToDispensed]
  @PresId				BIGINT
AS
BEGIN
	UPDATE prescription_details SET is_dispensed=1
	WHERE pres_id = @PresId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
