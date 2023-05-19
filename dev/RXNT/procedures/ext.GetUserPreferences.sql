SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	12-DEC-2018
Description			:	This procedure is used to get user preferences
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ext].[GetUserPreferences]	--9161,2824
	@UserId		BIGINT,
	@DoctorCompanyId	BIGINT	
AS
BEGIN
	SELECT ISNULL(is_bannerads_enabled,1)is_bannerads_enabled,ISNULL(D.time_difference,U.time_difference) as time_difference
	FROM doctor_info di WITH(NOLOCK)
	INNER JOIN doctors U WITH(NOLOCK) ON U.dr_id = di.dr_id
LEFT OUTER JOIN doctors D WITH(NOLOCK) ON D.dr_id = U.dr_last_alias_dr_id
WHERE di.dr_id = @UserId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
