SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 9-Feb-2018
-- Description:	Save Patient Hospitalization Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveHasPatientHospitalizationHx]
	@PatientId BIGINT,
	@HasNoHospitalization BIT,
	@DocotorId BIGINT,
	@AddedByDrID BIGINT
AS
BEGIN
	DECLARE @IsNew BIT;

	IF NOT EXISTS( SELECT 1 FROM [dbo].[patient_hx] WITH(NOLOCK)
			WHERE pat_id = @PatientId)
	BEGIN
		SET @IsNew = 1;
	END
	ELSE
	BEGIN
		SET @IsNew = 0;
	END
	
	IF @IsNew = 1
	BEGIN
		INSERT INTO patient_hx 
		(pat_id,has_nohosphx, hosphx_dr_id, hosphx_last_updated_on, hosphx_last_updated_by)
		VALUES
		(@PatientId, @HasNoHospitalization, @DocotorId, GETDATE(), @AddedByDrID)
	END
	ELSE
	BEGIN
		UPDATE patient_hx
		SET 
		has_nohosphx = @HasNoHospitalization,
		hosphx_dr_id = @DocotorId,
		hosphx_last_updated_on = GETDATE(),
		hosphx_last_updated_by = @AddedByDrID
		WHERE pat_id = @PatientId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
