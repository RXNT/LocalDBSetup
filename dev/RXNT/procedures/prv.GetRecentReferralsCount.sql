SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Balaji
Create date			:	09-SEP-2016
Description			:	This procedure is used to get recent referrals count
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[GetRecentReferralsCount]	
	-- Add the parameters for the stored procedure here
	@DoctorId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Count as int
    -- Insert statements for procedure here
	
	SELECT @Count=COUNT(1)
	FROM REFERRAL_MAIN R WITH(NOLOCK)
	--LEFT OUTER JOIN REFERRAL_TARGET_DOCS T WITH(NOLOCK) ON R.TARGET_DR_ID = T.TARGET_DR_ID 
	--LEFT OUTER JOIN referral_institutions RS WITH(NOLOCK) ON R.INST_ID = RS.INST_ID 
	--LEFT OUTER JOIN REFERRAL_STATUS S ON WITH(NOLOCK) R.REF_ID = S.REFERRAL_ID 
	WHERE R.MAIN_DR_ID = @DoctorId AND ref_start_date > getdate() - 30  
	
	
	Select @Count as ReferralsCount	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
