SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vidya
Create date			:	01-Sep-2016
Description			:	This procedure is used to get pending patient queue list
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [adm].[usp_GetPendingPatientQueue]	
	@QueueStatus VARCHAR(5)
AS
BEGIN
	Select	* 
	From	adm.PatientQueue WITH (NOLOCK)
	Where	QueueStatus = @QueueStatus
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
