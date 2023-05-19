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
CREATE PROCEDURE [dbo].[UpdatePatientExportRequest] 
	@RequestId BIGINT, 
	@FileName VARCHAR(100), 
	@FilePassword VARCHAR(100) = NULL, 
	@StatusId BIGINT
AS 
BEGIN 	
 UPDATE dbo.PatientFullExportRequest
 SET 
 FileName=@FileName,
 FilePassword=@FilePassword,
 StatusId=@StatusId,
 ProcessedDate=GETDATE()
 WHERE RequestId=@RequestId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
