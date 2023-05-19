SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
-- Author:		Vinod
-- Create date: 14-AUG-2018
Description			:	This procedure is used to save Patient Surgical Hx other infor
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SavePatientSurgicalHxOtherInfo]	
	@SurgicalHxOtherInfo VARCHAR(MAX),
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
		(pat_id, dr_id, added_by_dr_id, created_on, last_modified_on, last_modified_by, enable, surgeryhx_other)
		 VALUES
		(@PatientId, @DocotorId, @AddedByDrID, GETDATE(), GETDATE(), @DocotorId, 1, @SurgicalHxOtherInfo)
	END
	ELSE
	BEGIN
		UPDATE patient_social_hx
		SET
		surgeryhx_other=@SurgicalHxOtherInfo
		WHERE sochxid = @SocialHxId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
