SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 21-Jul-2016
-- Description:	Save Patient Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveHasPatientFamilyHx]
	@PatientId BIGINT,
	@HasNoFamilyHx BIT,
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
		(pat_id,has_nofhx, fhx_dr_id, fhx_last_updated_on, fhx_last_updated_by)
		VALUES
		(@PatientId, @HasNoFamilyHx, @DocotorId, GETDATE(), @AddedByDrID)
	END
	ELSE
	BEGIN
		UPDATE patient_hx
		SET 
		has_nofhx = @HasNoFamilyHx,
		fhx_dr_id = @DocotorId,
		fhx_last_updated_on = GETDATE(),
		fhx_last_updated_by = @AddedByDrID
		WHERE pat_id = @PatientId
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
