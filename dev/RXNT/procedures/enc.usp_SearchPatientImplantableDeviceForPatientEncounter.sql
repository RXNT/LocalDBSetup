SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	27-10-2017
Description			:	This procedure is used to Search Patient IMplantables Device
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [enc].[usp_SearchPatientImplantableDeviceForPatientEncounter] 
	@PatientId	BIGINT,
	@DoctorCompanyId BIGINT
AS
BEGIN
	SELECT 
		PID.PatientImplantableDeviceId,
		PID.DoctorCompanyId,
		PID.PatientId,
		PID.CreatedOn,
		PID.Active,
		PID.BatchNumber,
		PID.LotNumber,
		PID.SerialNumber,
		PID.ManufacturedDate,
		PID.ExpirationDate,
		ID.ImplantableDeviceId,
		ID.BrandName,
		ID.DeviceId
	FROM [ehr].[PatientImplantableDevice] PID
	INNER JOIN [ehr].[ImplantableDevice] ID ON PID.ImplantableDeviceId=ID.ImplantableDeviceId
	WHERE PatientId=@PatientId AND DoctorCompanyId=@DoctorCompanyId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
