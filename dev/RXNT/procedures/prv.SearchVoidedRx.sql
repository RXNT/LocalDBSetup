SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[SearchVoidedRx]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @IsAgent bit=0
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


	IF @IsRestrictToPersonalRx = 1 
		BEGIN
			IF @IsAgent = 1 
				BEGIN
					SELECT TOP 75 *, D.dr_prefix as Prim_Dr_Prefix, D.dr_suffix as Prim_Dr_Suffix,D.dr_first_name as Prim_Dr_First_Name,D.dr_last_name as Prim_Dr_Last_Name,D.dr_middle_initial as Prim_Dr_Middle_Name FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK) Left OUTER JOIN doctors D WITH(NOLOCK) ON A.prim_dr_id=D.dr_id WHERE A.PRIM_DR_ID = @UserId  ORDER BY pres_approved_date DESC, pa_last, pa_first 
				END
			ELSE
				BEGIN
					SELECT TOP 75 *, D.dr_prefix as Prim_Dr_Prefix, D.dr_suffix as Prim_Dr_Suffix,D.dr_first_name as Prim_Dr_First_Name,D.dr_last_name as Prim_Dr_Last_Name,D.dr_middle_initial as Prim_Dr_Middle_Name FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK) Left OUTER JOIN doctors D WITH(NOLOCK) ON A.prim_dr_id=D.dr_id  WHERE A.DR_ID = @UserId ORDER BY pres_approved_date DESC, pa_last, pa_first 
				END
		END
	ELSE
		BEGIN
			SELECT TOP 75 *, D.dr_prefix as Prim_Dr_Prefix, D.dr_suffix as Prim_Dr_Suffix,D.dr_first_name as Prim_Dr_First_Name,D.dr_last_name as Prim_Dr_Last_Name,D.dr_middle_initial as Prim_Dr_Middle_Name FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK) Left OUTER JOIN doctors D WITH(NOLOCK) ON A.prim_dr_id=D.dr_id  WHERE A.DG_ID = @DoctorGroupId ORDER BY  pres_approved_date DESC, pa_last, pa_first
		END    
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
