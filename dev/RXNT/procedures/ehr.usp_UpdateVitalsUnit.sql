SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	11-Nov-2016
Description			:	This procedure is used to update preferred vitals for logged in user
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_UpdateVitalsUnit]	
	@LoggedInUserId		BIGINT,
	@VitalsUnit			VARCHAR(5)
AS
BEGIN
	update doctor_info
	set vitals_unit_type = @VitalsUnit
	where dr_id = @LoggedInUserId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
