SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchRefillRx]
	@DoctorId int, @DoctorGroupId int, @bRestrictToPersonalRx bit = 1, @bAgent bit=0, @StartDate DATETIME=NULL, @EndDate DATETIME=NULL
AS
BEGIN
	SET NOCOUNT ON;
	IF @bRestrictToPersonalRx = 1 
		BEGIN
			IF @bAgent = 1 
				BEGIN
					SELECT TOP 75 A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, PRIM_DOCS.time_difference AS PRIM_TIME_DIFF FROM vwDrPendingPrescriptionLog A LEFT OUTER JOIN Doctors PRIM_DOCS on A.prim_dr_id = PRIM_DOCS.DR_ID WHERE A.PRIM_DR_ID = @DoctorId
					AND PRES_PRESCRIPTION_TYPE = 2
					AND ((@StartDate IS NULL AND @EndDate IS NULL) OR (pres_entry_date BETWEEN @StartDate AND @EndDate))
					order by pres_entry_date desc
				END
			ELSE
				BEGIN
					SELECT TOP 75  A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME,PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, PRIM_DOCS.time_difference AS PRIM_TIME_DIFF FROM vwDrPendingPrescriptionLog A LEFT OUTER JOIN Doctors PRIM_DOCS on A.prim_dr_id = PRIM_DOCS.DR_ID WHERE A.DR_ID = @DoctorId 
					AND PRES_PRESCRIPTION_TYPE = 2
					AND ((@StartDate IS NULL AND @EndDate IS NULL) OR (pres_entry_date BETWEEN @StartDate AND @EndDate))
					order by pres_entry_date desc
				END		
		END
	ELSE
		BEGIN
			SELECT TOP 75 A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, PRIM_DOCS.time_difference AS PRIM_TIME_DIFF FROM vwDrPendingPrescriptionLog A LEFT OUTER JOIN Doctors PRIM_DOCS on A.prim_dr_id = PRIM_DOCS.DR_ID WHERE A.DG_ID = @DoctorGroupId
			AND PRES_PRESCRIPTION_TYPE = 2
			AND ((@StartDate IS NULL AND @EndDate IS NULL) OR (pres_entry_date BETWEEN @StartDate AND @EndDate))
			order by pres_entry_date desc
		END   
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
