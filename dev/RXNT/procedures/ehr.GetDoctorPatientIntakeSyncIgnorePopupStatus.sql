SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 09-Jul-2020
-- Description:	to get the status of Showing the ignore Message on Patient Demographics Sync
-- =============================================

CREATE PROCEDURE [ehr].[GetDoctorPatientIntakeSyncIgnorePopupStatus]

@DoctorId bigint 
	AS 
	BEGIN
	   SELECT dont_ignore_popup_on_patient_intake_sync  FROM    doctor_info  Where dr_id = @DoctorId;   
	END

	
	
   
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
