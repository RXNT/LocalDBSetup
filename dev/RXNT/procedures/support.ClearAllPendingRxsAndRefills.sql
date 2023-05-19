SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	23-OCT-2017
-- Description:		Clear Pending prescriptions and refills for a doctor
-- =============================================
CREATE PROCEDURE [support].[ClearAllPendingRxsAndRefills]
  @DoctorId					BIGINT,
  @ClearPendingRx			BIT=0,
  @ClearPendingRefills		BIT=0,
  @Comments					VARCHAR(100)=NULL
AS
BEGIN
	DECLARE @DoctorGroupId AS BIGINT
	SELECT @DoctorGroupId=dg_id FROM doctors WHERE dr_id=@DoctorId
	IF(@ClearPendingRx=1)
	BEGIN
		UPDATE prescriptions SET dr_id=-dr_id, dg_id=-dg_id, pharm_id=-pharm_id, pa_id=-pa_id,
		prim_dr_id=-prim_dr_id,authorizing_dr_id=-authorizing_dr_id,writing_dr_id=-writing_dr_id, pres_void_comments=@Comments
		WHERE dg_id=@DoctorGroupId and dr_id=@DoctorId
		AND (dbo.prescriptions.pres_approved_date IS NULL) AND (dbo.prescriptions.pres_void = 0)
		AND PRES_PRESCRIPTION_TYPE <> 2
	END
	IF(@ClearPendingRefills=1)
	BEGIN
		UPDATE prescriptions SET dr_id=-dr_id, dg_id=-dg_id, pharm_id=-pharm_id, pa_id=-pa_id,
		prim_dr_id=-prim_dr_id,authorizing_dr_id=-authorizing_dr_id,writing_dr_id=-writing_dr_id, pres_void_comments=@Comments
		WHERE dg_id=@DoctorGroupId and dr_id=@DoctorId
		AND (dbo.prescriptions.pres_approved_date IS NULL) AND (dbo.prescriptions.pres_void = 0)
		AND PRES_PRESCRIPTION_TYPE = 2	
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
