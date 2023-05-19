SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Pradeep P
-- Create date: 13-Oct-2020
-- Description:	to get the status of Showing the ignore Message for all configuration
-- =============================================

CREATE PROCEDURE [ehr].[GetDoctorIgnoreStatusConfiguration]

@DoctorId bigint 
	AS 
	BEGIN
	   SELECT dont_ignore_popup_on_patient_intake_sync, dont_ignore_popup_on_doctor_sign_encounter ,dont_ignore_popup_on_doctor_release_encounter  FROM    doctor_info  Where dr_id = @DoctorId;   
	END


	
   
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
