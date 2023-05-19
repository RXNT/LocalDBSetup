SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to get all patient merge statuses
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_GetPatientMergeStatuses]
AS
BEGIN
	SET NOCOUNT ON;	

	Select * From dbo.Patient_merge_status
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
