SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 14-SEP-2020
-- Description:	To Update Encounter Sign Confirmation Popup
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpdateEncounterSignConfirmationPopup]
	@DoctorId BIGINT,
	@HideSignatureInformation BIT 
AS
BEGIN
 UPDATE doctor_info 
	SET hide_encounter_sign_confirmation_popup = @HideSignatureInformation
 WHERE DR_ID = @DoctorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
