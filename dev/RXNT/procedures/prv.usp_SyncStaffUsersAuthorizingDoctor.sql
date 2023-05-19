SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ===========================================================
-- Author:		Ayja Weems
-- Create date: 29-Apr-2021
-- Description:	Update the authorizing doctor id of all staff
--				users with the same main doctor.
-- ===========================================================
CREATE PROCEDURE [prv].[usp_SyncStaffUsersAuthorizingDoctor] 
	@MainDoctorId BIGINT, 
	@AuthorizingDoctorId BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE doctors 
	SET dr_last_auth_dr_id = @AuthorizingDoctorId
	WHERE dr_last_alias_dr_id = @MainDoctorId
		AND prescribing_authority IN (1, 2)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
