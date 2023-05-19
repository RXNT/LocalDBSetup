SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	11-AUGUST-2016
Description			:	This procedure is used to Save Patient Profile]
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SavePatientProfile]	
	@PatientId BIGINT,
	@AddedByDoctorId BIGINT,
	@EntryDate DATETIME,
	@LastUpdateDate DATETIME,
	@LastUpdateDoctorId BIGINT,
	@ItemId BIGINT,
	@ItemText varchar(225),
	@Index BIGINT,
	@UpdatePatientProfileDetails BIT = 1
	

AS
BEGIN
DECLARE @ProfileId BIGINT
		
IF NOT EXISTS(SELECT PROFILE_ID FROM PATIENT_PROFILE WHERE PATIENT_ID = @PatientId)
BEGIN
		INSERT INTO [patient_profile] ([patient_id],[added_by_dr_id],[entry_date],[last_update_date] ,[last_update_dr_id]) 
        VALUES(@PatientId, @AddedByDoctorId, @EntryDate, @LastUpdateDate, @LastUpdateDoctorId);
        SET @ProfileId = SCOPE_IDENTITY()
END
ELSE
BEGIN
		SELECT @ProfileId = PROFILE_ID FROM PATIENT_PROFILE WHERE PATIENT_ID = @PatientId

		UPDATE PATIENT_PROFILE 
		SET LAST_UPDATE_DATE = @LastUpdateDate, LAST_UPDATE_DR_ID = @LastUpdateDoctorId
		WHERE PROFILE_ID = @profileId;	
		
		IF(@Index=0)
		BEGIN	
				DELETE FROM PATIENT_PROFILE_DETAILS WHERE PROFILE_ID = @profileId;
		END
END
IF (@ProfileId>0 and @UpdatePatientProfileDetails=1)
BEGIN
		INSERT INTO [patient_profile_details] ([profile_id],[item_id],[item_text]) 
        VALUES (@profileId, @ItemId, @ItemText);
END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
