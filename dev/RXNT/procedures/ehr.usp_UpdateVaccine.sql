SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	19-AUGUST-2016
Description			:	To Update Vaccine Route
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_UpdateVaccine]	
	@VaccineId BIGINT,
	@Route VARCHAR(50),
	@RouteCode VARCHAR(3)
AS
BEGIN
 Update [dbo].[tblVaccines] 
 Set [route]=@route,
 route_code=@RouteCode 
 Where vac_id= @VaccineId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
