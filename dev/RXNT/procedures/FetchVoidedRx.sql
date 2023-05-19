SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchVoidedRx]
	@DoctorId int, @DoctorGroupId int, @bRestrictToPersonalRx bit = 1, @bAgent bit=0
AS
BEGIN
	SET NOCOUNT ON;
	IF @bRestrictToPersonalRx = 1 
		BEGIN
			IF @bAgent = 1 
				BEGIN
					SELECT TOP 75 * FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK) 
					WHERE 
					A.DG_ID = @DoctorGroupId 
					AND A.PRIM_DR_ID = @DoctorId  
					ORDER BY pres_approved_date DESC, pa_last, pa_first 
				END
			ELSE
				BEGIN
					SELECT TOP 75 * FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK)  
					WHERE 
					A.DG_ID = @DoctorGroupId 
					AND A.DR_ID = @DoctorId 
					ORDER BY pres_approved_date DESC, pa_last, pa_first 
				END		
		END
	ELSE
		BEGIN
			SELECT TOP 75 * FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK)  
			WHERE 
			A.DG_ID = @DoctorGroupId 
			ORDER BY  pres_approved_date DESC, pa_last, pa_first
		END   
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
