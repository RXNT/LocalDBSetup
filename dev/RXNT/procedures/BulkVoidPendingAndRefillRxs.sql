SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	05-APR-2018
-- Description:		BulkVoidPendingAndRefillRxs
-- =============================================
CREATE PROCEDURE [dbo].[BulkVoidPendingAndRefillRxs]
  @DoctorGroupId			BIGINT,
  @StartDate				DATETIME=NULL,
  @EndDate					DATETIME=NULL,
  @ClearPendingRx			BIT=0,
  @ClearPendingRefills		BIT=0,
  @Comments					VARCHAR(100)=NULL
AS
BEGIN
	IF(@ClearPendingRx=1)
	BEGIN
		UPDATE prescriptions SET dr_id=-dr_id, dg_id=-dg_id, pharm_id=-pharm_id, pa_id=-pa_id,
		prim_dr_id=-prim_dr_id,authorizing_dr_id=-authorizing_dr_id,writing_dr_id=-writing_dr_id, pres_void_comments=@Comments
		WHERE dg_id=@DoctorGroupId
		AND dbo.prescriptions.pres_entry_date BETWEEN @StartDate AND @EndDate
		AND (dbo.prescriptions.pres_approved_date IS NULL) AND (dbo.prescriptions.pres_void = 0)
		AND PRES_PRESCRIPTION_TYPE NOT IN(2,5)
	END
	IF(@ClearPendingRefills=1)
	BEGIN
		UPDATE prescriptions SET dr_id=-dr_id, dg_id=-dg_id, pharm_id=-pharm_id, pa_id=-pa_id,
		prim_dr_id=-prim_dr_id,authorizing_dr_id=-authorizing_dr_id,writing_dr_id=-writing_dr_id, pres_void_comments=@Comments
		WHERE dg_id=@DoctorGroupId
		AND dbo.prescriptions.pres_entry_date BETWEEN @StartDate AND @EndDate
		AND (dbo.prescriptions.pres_approved_date IS NULL) AND (dbo.prescriptions.pres_void = 0)
		AND PRES_PRESCRIPTION_TYPE IN (2,5)
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
