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
CREATE PROCEDURE [dbo].[GetAllDoctorPatientExportRequest] 
	@DoctorId BIGINT, 
	@DoctorGroupId BIGINT, 
	@DoctorCompanyId BIGINT
AS 
BEGIN 	
	SELECT TOP 1 RequestId,StatusId,FileName,FilePassword,ProcessedDate FROM dbo.PatientFullExportRequest WITH(NOLOCK)
	WHERE DoctorId=@DoctorId ORDER BY RequestId DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
