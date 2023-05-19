SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [ehr].[SearchPendingRxForPatient]
	@UserId BIGINT, 
	@DoctorGroupId BIGINT,
	@IsRestrictToPersonalRx BIT = 1,
	@IsAgent BIT=0,
	@PatientId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	IF @IsRestrictToPersonalRx = 1 
		BEGIN
			IF @IsAgent = 1 
				BEGIN
					SELECT TOP 75  A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, PRIM_DOCS.time_difference AS PRIM_TIME_DIFF
					FROM vwDrPendingPrescriptionLog A WITH(NOLOCK)
					LEFT OUTER JOIN Doctors PRIM_DOCS WITH(NOLOCK) ON A.prim_dr_id = PRIM_DOCS.DR_ID
					WHERE A.PRIM_DR_ID = @UserId  AND A.PRES_PRESCRIPTION_TYPE NOT IN(2,5)
					AND A.pa_id=@PatientId AND ISNULL(A.hide_on_pending_rx,0)=0
					ORDER BY pres_entry_date DESC, pa_last, pa_first 
				END
			ELSE
				BEGIN
					SELECT TOP 75  A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, PRIM_DOCS.time_difference AS PRIM_TIME_DIFF
					FROM vwDrPendingPrescriptionLog A WITH(NOLOCK)
					LEFT OUTER JOIN Doctors PRIM_DOCS WITH(NOLOCK) ON A.prim_dr_id = PRIM_DOCS.DR_ID 
					WHERE A.DR_ID = @UserId AND A.PRES_PRESCRIPTION_TYPE NOT IN(2,5)
					AND A.pa_id=@PatientId AND ISNULL(A.hide_on_pending_rx,0)=0
					ORDER BY pres_entry_date DESC,pa_last, pa_first
				END		
		END
	ELSE
		BEGIN
			SELECT TOP 75  A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, PRIM_DOCS.time_difference AS PRIM_TIME_DIFF
			FROM vwDrPendingPrescriptionLog A WITH(NOLOCK)
			LEFT OUTER JOIN Doctors PRIM_DOCS WITH(NOLOCK) ON A.prim_dr_id = PRIM_DOCS.DR_ID
			WHERE A.DG_ID = @DoctorGroupId AND A.PRES_PRESCRIPTION_TYPE  NOT IN(2,5)
			AND A.pa_id=@PatientId AND ISNULL(A.hide_on_pending_rx,0)=0
			ORDER BY pres_entry_date DESC, pa_last, pa_first
		END   
	RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
