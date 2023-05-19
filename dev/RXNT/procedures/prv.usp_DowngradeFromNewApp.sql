SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram G
-- Create date: 4-Oct-2016
-- Description:	To Downlgrade new app
-- Modified By: Singaravelan
-- Modified Date: 6-Desc-2016 For ED 1477
-- =============================================
CREATE PROCEDURE [prv].[usp_DowngradeFromNewApp]
	@LoggedInUserId BIGINT,
	@DashboardVersion BIGINT OUTPUT
AS
BEGIN
		
	--UPDATE doctor_info
	--SET is_custom_tester = @DashboardVersion,
	--encounter_version = null
	--WHERE dr_id = @LoggedInUserId
	
	UPDATE doctor_info
	SET is_custom_tester = is_custom_tester | 1
	WHERE 1 = 1
	AND dr_id = @LoggedInUserId
	AND (is_custom_tester & 1) <> 1
	
	UPDATE doctor_info
	SET is_custom_tester = is_custom_tester ^ 4
	WHERE 1 = 1
	AND dr_id = @LoggedInUserId
	AND (is_custom_tester & 4) = 4
	
	UPDATE doctor_info
	SET is_custom_tester = is_custom_tester ^ 8
	WHERE 1 = 1
	AND dr_id = @LoggedInUserId
	AND (is_custom_tester & 8) = 8
	
	SELECT @DashboardVersion = is_custom_tester from doctor_info where dr_id = @LoggedInUserId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
