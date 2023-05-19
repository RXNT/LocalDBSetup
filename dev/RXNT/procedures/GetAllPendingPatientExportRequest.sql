SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Niyaz
Create date			: 10th-Sep-2018
Description			: 
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [dbo].GetAllPendingPatientExportRequest
AS 
BEGIN 	
	SELECT * FROM [PatientFullExportRequest] WITH(NOLOCK) WHERE StatusId=1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
