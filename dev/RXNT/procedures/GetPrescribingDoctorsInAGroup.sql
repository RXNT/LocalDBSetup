SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author:		
-- Create date: 26-Sept-2019
-- Description:	Get 
-- Modified By: 
-- Modified Date: 
-- ====================================================
CREATE PROCEDURE [dbo].[GetPrescribingDoctorsInAGroup]
	@DG_ID BIGINT
AS

BEGIN
	SELECT d.dr_id, d.dg_id,d.dr_prefix, d.dr_first_name, d.dr_middle_initial, d.dr_last_name, d.dr_suffix ,
		d.prescribing_authority
	FROM doctors d WITH(NOLOCK) 
	WHERE d.dg_id= @DG_ID AND D.DR_ENABLED = 1 and
	 loginlock = 0 and lowusage_lock = 0 AND 
	(D.billing_enabled=0 or (D.billing_enabled=1 and D.billingDate > getdate())) And d.prescribing_authority > 2
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
