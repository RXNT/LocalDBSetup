SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*   
=======================================================================================  
Author				:	Nambi  
Create date			:	29-APR-2019
Description			:	This procedure is used to Lock V1 Accounts
Last Modified By	:	Nambi
Last Modifed Date	:	08-FEB-2021
Last Modification	:	ADV2-998: Lock accounts only if they are not locked already
=======================================================================================  
*/

CREATE PROCEDURE [lcn].[usp_LockV1Accounts]
(
	@V1Accounts			XML,
	@LockAccounts		BIT,
	@LockingDate		DATETIME = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE	DR
	SET		DR.billing_enabled = @LockAccounts,
			DR.billingDate = @LockingDate
	FROM	[dbo].[doctors] DR WITH(NOLOCK)
			INNER JOIN (SELECT t.value('.', 'BIGINT') AS dr_id
				from @V1Accounts.nodes('ArrayOfLong/long') as x(t)) ACC ON DR.dr_id=ACC.dr_id
	WHERE	(@LockAccounts = 1 AND ISNULL(DR.billing_enabled, 0) = 0) OR (ISNULL(@LockAccounts, 0) = 0)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
