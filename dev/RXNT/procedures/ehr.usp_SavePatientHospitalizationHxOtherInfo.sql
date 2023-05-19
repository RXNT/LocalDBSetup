SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 14-AUG-2018
-- Description:	To Save Patient Hospitalization Hx Other Info
-- =============================================

CREATE PROCEDURE [ehr].[usp_SavePatientHospitalizationHxOtherInfo]
	@HospitalizationHxOtherInfo VARCHAR(MAX),
	@PatientId BIGINT,
	@DocotorId BIGINT,
	@AddedByDrID BIGINT
AS
BEGIN
	
	DECLARE @SocialHxId AS BIGINT=0
	SELECT @SocialHxId = ISNULL(sochxid,0) FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1
	IF @SocialHxId <= 0
	BEGIN
		INSERT patient_social_hx 
		(pat_id, dr_id, added_by_dr_id, created_on, last_modified_on, last_modified_by, enable, hospitalizationhx_other)
		 VALUES
		(@PatientId, @DocotorId, @AddedByDrID, GETDATE(), GETDATE(), @DocotorId, 1, @HospitalizationHxOtherInfo)
	END
	ELSE
	BEGIN
		UPDATE patient_social_hx
		SET
		hospitalizationhx_other=@HospitalizationHxOtherInfo
		WHERE sochxid = @SocialHxId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
