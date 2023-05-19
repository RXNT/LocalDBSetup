SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		SHEIK IBRAHIM
-- Create date: 14-Aug-2019
-- Description:	to save other hx info
-- =============================================
CREATE PROCEDURE [enc].[usp_SavePatientHxOtherInfo]
(
	@PatientId		BIGINT,
	@Block			VARCHAR(10),
	@Info			VARCHAR(MAX),
	@DoctorId		BIGINT
)
AS
BEGIN
	IF (@Block='MedicalHx')
	BEGIN
		IF NOT EXISTS (SELECT * FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1)
		BEGIN
			INSERT INTO patient_social_hx (pat_id,dr_id,added_by_dr_id,created_on, enable, medicalhx_other) 
			VALUES (@PatientId,@DoctorId,@DoctorId,GETDATE(),1, @Info);
		END
		ELSE
		BEGIN
			Update patient_social_hx set medicalhx_other=@Info WHERE pat_id = @PatientId
		END
	END
	ELSE IF (@Block='SurgeryHx')
		IF NOT EXISTS (SELECT * FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1)
		BEGIN
			INSERT INTO patient_social_hx (pat_id,dr_id,added_by_dr_id,created_on, enable, surgeryhx_other) 
			VALUES (@PatientId,@DoctorId,@DoctorId,GETDATE(),1, @Info);
		END
		ELSE
		BEGIN
			Update patient_social_hx set surgeryhx_other=@Info WHERE pat_id = @PatientId
		END  
	ELSE IF (@Block='HospitalHx')
		IF NOT EXISTS (SELECT * FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1)
		BEGIN
			INSERT INTO patient_social_hx (pat_id,dr_id,added_by_dr_id,created_on, enable, hospitalizationhx_other) 
			VALUES (@PatientId,@DoctorId,@DoctorId,GETDATE(),1, @Info);
		END
		ELSE
		BEGIN
			Update patient_social_hx set hospitalizationhx_other=@Info WHERE pat_id = @PatientId
		END
	ELSE IF (@Block='FamilyHx')
		IF NOT EXISTS (SELECT * FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1)
		BEGIN
			INSERT INTO patient_social_hx (pat_id,dr_id,added_by_dr_id,created_on, enable, familyhx_other) 
			VALUES (@PatientId,@DoctorId,@DoctorId,GETDATE(),1, @Info);
		END
		ELSE
		BEGIN
			Update patient_social_hx set familyhx_other=@Info WHERE pat_id = @PatientId
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
