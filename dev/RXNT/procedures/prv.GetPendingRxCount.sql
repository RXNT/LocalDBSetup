SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[GetPendingRxCount]
	@UserId INT, 
	@DoctorGroupId INT, 
	@IsRestrictToPersonalRx BIT = 1, 
	@IsAgent BIT=0
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @PreferredPrescriberId BIGINT = 0;
	
	SELECT @PreferredPrescriberId=di.staff_preferred_prescriber 
	FROM dbo.doctor_info di WITH(NOLOCK)
	WHERE di.dr_id=@UserId 
	
	IF(@PreferredPrescriberId>0)
	BEGIN
		SET @UserId = @PreferredPrescriberId;
		SET @IsRestrictToPersonalRx = 1;
	END
	DECLARE @Count AS INT
	IF @IsRestrictToPersonalRx = 1 
	BEGIN
		IF @IsAgent = 1 
			BEGIN
				SELECT  @Count=COUNT(1) 
				FROM vwDrPendingPrescriptionLog A  
				LEFT OUTER JOIN Doctors PRIM_DOCS  WITH(NOLOCK) ON A.prim_dr_id = PRIM_DOCS.DR_ID 
				WHERE A.PRIM_DR_ID = @UserId  
				AND A.PRES_PRESCRIPTION_TYPE NOT IN (2,5)
				AND ISNULL(A.hide_on_pending_rx,0)=0
			END
		ELSE
		BEGIN
			SELECT  @Count=COUNT(1) 
			FROM vwDrPendingPrescriptionLog A 
			LEFT OUTER JOIN Doctors PRIM_DOCS  WITH(NOLOCK) ON A.prim_dr_id = PRIM_DOCS.DR_ID 
			WHERE A.DR_ID = @UserId 
			AND A.PRES_PRESCRIPTION_TYPE NOT IN (2,5)
			AND ISNULL(A.hide_on_pending_rx,0)=0
		END		
	END
	ELSE
	BEGIN
		SELECT @Count=COUNT(1) 
		FROM vwDrPendingPrescriptionLog A  WITH(NOLOCK) 
		LEFT OUTER JOIN Doctors PRIM_DOCS  WITH(NOLOCK) ON A.prim_dr_id = PRIM_DOCS.DR_ID 
		WHERE A.DG_ID = @DoctorGroupId
		AND A.PRES_PRESCRIPTION_TYPE  NOT IN (2,5)
		AND ISNULL(A.hide_on_pending_rx,0)=0
	END 
	SELECT @Count as PendingRxCount	  
	RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
