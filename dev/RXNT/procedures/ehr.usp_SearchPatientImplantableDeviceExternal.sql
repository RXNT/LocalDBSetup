SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [ehr].[usp_SearchPatientImplantableDeviceExternal] 
	@PatientId	BIGINT,
	@DoctorCompanyId BIGINT

AS
BEGIN
	SELECT 
		PID.PatientImplantableDeviceExtId,
		PID.DoctorCompanyId,
		PID.PatientId,
		PID.CreatedOn,
		PID.Active,
		PID.BatchNumber,
		PID.LotNumber,
		PID.SerialNumber,
		PID.ManufacturedDate,
		PID.ExpirationDate,
		PID.Source,
		ID.ImplantableDeviceId,
		ID.BrandName,
		ID.DeviceId
	FROM 	[ehr].[PatientImplantableDeviceExternal] PID
			INNER JOIN [ehr].[ImplantableDevice] ID ON PID.ImplantableDeviceId=ID.ImplantableDeviceId
	WHERE 	PatientId=@PatientId AND DoctorCompanyId=@DoctorCompanyId
			
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
