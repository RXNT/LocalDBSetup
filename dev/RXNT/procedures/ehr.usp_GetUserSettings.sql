SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	04-JULY-2016
Description			:	This procedure is used to get user settings
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[usp_GetUserSettings]	
	@UserId		BIGINT
AS
BEGIN
	select 
	dr_opt_two_printers, dr_severity,printpref, df.is_coupon_enabled,
	df.settings, df.is_custom_tester,df.VersionURL,df.encounter_version, df.vitals_unit_type
	from doctors dr left outer join doctor_info df on dr.dr_id = df.dr_id where dr.dr_id = @UserId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
