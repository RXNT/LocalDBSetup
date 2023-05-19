SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 22-June-2016
-- Description:	To Reinstate Prescription
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_ReinstatePrescription]
	@PrescriptionId BIGINT
AS 
BEGIN
  UPDATE PRESCRIPTION_DETAILS SET HISTORY_ENABLED = 1 WHERE PRES_ID = @PrescriptionId
  
  UPDATE PRESCRIPTION_DETAILS_ARCHIVE SET HISTORY_ENABLED = 1 WHERE PRES_ID = @PrescriptionId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
