SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchPendingRxCount]	
	@DoctorId int, @DoctorGroupId int, @bRestrictToPersonalRx bit = 1, @bAgent bit=0
AS
BEGIN
	SET NOCOUNT ON;
	IF @bRestrictToPersonalRx = 1 
		BEGIN
			IF @bAgent = 1 
				BEGIN
					SELECT DISTINCT COUNT(A.PRES_ID) PEND_COUNT FROM vwDrPendingPrescriptionLog A WHERE A.PRIM_DR_ID = @DoctorId AND  PRES_PRESCRIPTION_TYPE  NOT IN(2,5)
				END
			ELSE
				BEGIN
					SELECT DISTINCT COUNT(A.PRES_ID) PEND_COUNT FROM vwDrPendingPrescriptionLog A WHERE A.DR_ID = @DoctorId AND  PRES_PRESCRIPTION_TYPE NOT IN(2,5)
				END
		
		END
	ELSE
		BEGIN
			SELECT DISTINCT COUNT(A.PRES_ID) PEND_COUNT FROM vwDrPendingPrescriptionLog A WHERE A.DG_ID = @DoctorGroupId AND  PRES_PRESCRIPTION_TYPE  NOT IN(2,5)
		END   
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
