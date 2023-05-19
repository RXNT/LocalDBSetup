SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: 28-Jun-2017
-- Description:	To Mark Patient as Discharged
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatient]
	@DoctorId BIGINT,
	@DoctorCompanyId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	DECLARE @FlagText AS VARCHAR(100)
	IF EXISTS(
		SELECT	NULL 
		FROM	dbo.patients pat WITH (NOLOCK)
		Where	pa_id = @PatientId)
	BEGIN
		IF NOT EXISTS(
			Select	NULL 
			From	dbo.patient_flag_details WITH (NOLOCK)
			WHERE	pa_id = @PatientId AND flag_id = 1) --Discharged
		BEGIN
			select @FlagText = flag_title From [dbo].[patient_flags] WITH (nolock) Where flag_id = 1
			INSERT INTO [dbo].[patient_flag_details] ([pa_id],[flag_id],[flag_text],[dr_id]) 
			VALUES (@PatientId, 1, @FlagText, @DoctorId)
		END
		UPDATE patients 
		SET dg_id=-dg_id 
		WHERE pa_id=@PatientId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
