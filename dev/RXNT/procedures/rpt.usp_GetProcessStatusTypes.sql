SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to get process status types
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_GetProcessStatusTypes]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT	SPS.* 
	FROM	rpt.ProcessStatusTypes SPS WITH (NOLOCK)

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
