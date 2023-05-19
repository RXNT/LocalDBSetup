SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	11-SEPT-2018
Description			:	This procedure is used to Generate Patient Portal Registration Pin
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [dbo].[usp_GeneratePatientPortalRegistrationPin]
	@PatientId				BIGINT,
	@RegistrationPin		VARCHAR(10),
	@DoctorId				BIGINT=0,
	@Source					SMALLINT
AS
BEGIN
	UPDATE	[patient_reg_db]
	SET		active=0, 
			last_modified_by=@DoctorId,
			last_modified_date=GETDATE()
	WHERE	pa_id=@PatientId
			AND ISNULL(active,0)=1
	
	INSERT INTO [patient_reg_db] ([dr_id],[pa_id],[pincode],[date_created],[src_type], [active])
	VALUES(@DoctorId, @PatientId, @RegistrationPin, getdate(), @Source, 1)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
