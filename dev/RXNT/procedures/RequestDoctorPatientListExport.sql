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
CREATE PROCEDURE [dbo].RequestDoctorPatientListExport
	@DoctorId	BIGINT,
	@DoctorGroupId	BIGINT,
	@DoctorCompanyId	BIGINT
AS 
BEGIN 	
	INSERT INTO [PatientFullExportRequest] 
	(DoctorId,DoctorGroupId,DoctorCompanyId,StatusId,CreatedOn,CreatedBy,Active)
	VALUES
	(@DoctorId,@DoctorGroupId,@DoctorCompanyId,1,GETDATE(),@DoctorId,1)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
