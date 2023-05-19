SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 22-June-2016
-- Description:	To Discharge Prescription
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DischargePrescription]
	@PrescriptionId BIGINT,
	@Reason VARCHAR(MAX),
	@DischargeDoctorId BIGINT
AS 
BEGIN
 UPDATE PRESCRIPTION_DETAILS 
	SET HISTORY_ENABLED = 0, discharge_desc=@Reason, discharge_date=getdate(), discharge_dr_id=@DischargeDoctorId 
	WHERE PRES_ID = @PrescriptionId
	
	
 UPDATE PRESCRIPTION_DETAILS_ARCHIVE 
 SET HISTORY_ENABLED = 0, discharge_desc=@Reason, discharge_date=getdate(), discharge_dr_id=@DischargeDoctorId 
 WHERE PRES_ID = @PrescriptionId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
