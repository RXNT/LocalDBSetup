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
CREATE PROCEDURE [dbo].[GetStaffDoctorPreference]
(
	@StaffId	BIGINT
)
AS
BEGIN
	SELECT staff_preferred_prescriber FROM doctor_info WHERE dr_id=@StaffId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
