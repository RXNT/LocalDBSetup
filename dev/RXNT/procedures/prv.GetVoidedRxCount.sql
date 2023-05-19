SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[GetVoidedRxCount]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @IsAgent bit=0
WITH RECOMPILE
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
	Declare @Count as int
	IF @IsRestrictToPersonalRx = 1 
		BEGIN
			IF @IsAgent = 1 
				BEGIN
					SELECT @Count=COUNT(1)FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK) WHERE A.PRIM_DR_ID = @UserId   
				END
			ELSE
				BEGIN
					SELECT @Count=COUNT(1) FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK)  WHERE A.DR_ID = @UserId 
				END		
		END
	ELSE
		BEGIN
			SELECT @Count=COUNT(1) FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK)  WHERE A.DG_ID = @DoctorGroupId 
		END 
		
	If @Count>75
	Begin
		Set @Count=75
	End
	Select @Count as VoidedRxCount		  
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
