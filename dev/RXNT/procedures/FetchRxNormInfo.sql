SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vijay
Create date			:	02-Feb-2020
Description			:	Fetch Rx NormInfo by DrugId
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [dbo].[FetchRxNormInfo]
	@DrugId	INT
AS
BEGIN

	SELECT RxNormCode, EVD_EXT_VOCAB_TYPE_ID FROM vwRxNormCodes WITH(NOLOCK) WHERE Medid = @DrugId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
