SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Pradeep P
-- Create date: 13-Oct-2020
-- Description:	to update the status of Showing the ignore Message for all configuration
-- =============================================

CREATE PROCEDURE [ehr].[usp_UpdateDoctorIgnoreStatusConfiguration]
		@DoctorId bigint,
		@PopupType VARCHAR(100),
		@DontShowIgnoreAlertMessage bit
	AS 
	BEGIN
		IF @PopupType = 'DontIgnorePopupOnPatientIntakeSync'
		BEGIN
			UPDATE dbo.doctor_info	
			SET dont_ignore_popup_on_patient_intake_sync= @DontShowIgnoreAlertMessage       
			WHERE dr_id = @DoctorId    
		END
		ELSE IF @PopupType = 'DontIgnoreSignConfirmationPopup'
		BEGIN
			UPDATE dbo.doctor_info	
			SET dont_ignore_popup_on_doctor_sign_encounter= @DontShowIgnoreAlertMessage       
			WHERE dr_id = @DoctorId    
		END
		ELSE IF @PopupType = 'DontIgnoreReleaseConfirmationPopup'
		BEGIN
			UPDATE dbo.doctor_info	
			SET dont_ignore_popup_on_doctor_release_encounter= @DontShowIgnoreAlertMessage       
			WHERE dr_id = @DoctorId    
		END
	END

	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
