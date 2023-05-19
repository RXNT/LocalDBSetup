SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	18-AUGUST-2016
Description			:	To get immunization registry settings
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetImmunizationRegistrySettings]	
	@DoctorGroupId BIGINT

AS
BEGIN
	SELECT 
	sending_facilityid,
	dg_id,
	added_by ,
	-- even more reason to start adding SPs to review
	Receving_FacilityId
	FROM immunization_registry_settings WITH(NOLOCK)
	WHERE 
	dg_id = @DoctorGroupId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
