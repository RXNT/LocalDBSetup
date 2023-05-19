SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[ProcessFlagsUpdate]
--	@GroupId BIGINT
AS
BEGIN
	
	UPDATE  TOP (50000) pfd  SET pfd.flag_id=pf.flag_id 
	FROM patients pat WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN patient_flag_details pfd WITH(NOLOCK) ON pat.pa_id=pfd.pa_id
	INNER JOIN patient_flags pf WITH(NOLOCK) ON pf.dc_id=dg.dc_id AND pfd.flag_id=pf.parent_flag_id
	--WHERE pat.dg_id=@GroupId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
