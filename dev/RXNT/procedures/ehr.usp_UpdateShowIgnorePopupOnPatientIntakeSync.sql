SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 09-Jul-2020
-- Description:	To update the status of Showing the ignore Message on Patient Intake Sync
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpdateShowIgnorePopupOnPatientIntakeSync]
		@DoctorId bigint,
		@DontShowIgnoreAlertMessage bit
	AS 
	BEGIN
	   UPDATE dbo.doctor_info	
			SET
				dont_ignore_popup_on_patient_intake_sync= @DontShowIgnoreAlertMessage       
			WHERE 
				dr_id = @DoctorId    
	END


	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
