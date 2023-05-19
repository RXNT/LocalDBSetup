SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	23-OCT-2018
Description			:	This procedure is used to Save Patient Info From PHR
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SavePatientInfoFromPHR]	
	@PatientId					BIGINT,
	@DoctorId					BIGINT,
	@SexualOrientation			BIGINT=0,
	@SexualOrientationDetail	VARCHAR(200)=NULL,
	@GenderIdentity				BIGINT=0,
	@GenderIdentityDetail		VARCHAR(200)=NULL

AS
BEGIN
	IF NOT EXISTS(SELECT TOP 1 1 FROM [dbo].[patient_extended_details] WITH(NOLOCK) WHERE pa_id=@PatientId)
	BEGIN
		INSERT INTO [dbo].[patient_extended_details]
		([pa_id], [pa_ext_ref], [prim_dr_id], [dr_id], [pa_sexual_orientation], [pa_sexual_orientation_detail],
		[pa_gender_identity], [pa_gender_identity_detail])
		VALUES (@PatientId, '',  @DoctorId, @DoctorId, @SexualOrientation, @SexualOrientationDetail,
		@GenderIdentity, @GenderIdentityDetail)
	END
	ELSE
	BEGIN
		UPDATE PED
		SET [pa_sexual_orientation] = @SexualOrientation,
			[pa_sexual_orientation_detail] = @SexualOrientationDetail,
			[pa_gender_identity] = @GenderIdentity,
			[pa_gender_identity_detail] = @GenderIdentityDetail
		FROM [dbo].[patient_extended_details] PED WITH(NOLOCK)
		INNER JOIN patients P WITH(NOLOCK) ON PED.pa_id=P.pa_id
		WHERE P.pa_id=@PatientId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
