SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author:		JahabarYusuff M
-- Create date: 15-Jan-2019
-- Description:	to get the doctor list
-- Modified By: 
-- Modified Date: 
-- ====================================================
CREATE PROCEDURE [enc].[usp_GetUserGroupDoctors]
	@DG_ID BIGINT,
	@Name Varchar(50)
AS

BEGIN
		SELECT d.dr_id, d.dg_id,d.dr_prefix, d.dr_first_name, d.dr_middle_initial, d.dr_last_name, d.dr_suffix ,
		 d.prescribing_authority
	FROM doctors d WITH(NOLOCK) 
	WHERE ( d.dr_first_name LIKE @Name+'%'  OR d.dr_last_name LIKE @Name+'%' ) AND  d.dg_id=@DG_ID AND D.DR_ENABLED = 1 and
	 loginlock = 0 and lowusage_lock = 0 AND 
	(D.billing_enabled=0 or (D.billing_enabled=1 and D.billingDate > getdate())) And d.prescribing_authority > 2
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
