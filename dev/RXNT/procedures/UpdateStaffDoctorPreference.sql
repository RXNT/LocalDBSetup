SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Niyaz
Create date			:	17-DEC-2018
Description			:	
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[UpdateStaffDoctorPreference]
(
	@DoctorId	BIGINT,
	@StaffId	BIGINT
)
AS
BEGIN
	UPDATE doctor_info SET staff_preferred_prescriber=@DoctorId WHERE dr_id=@StaffId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
