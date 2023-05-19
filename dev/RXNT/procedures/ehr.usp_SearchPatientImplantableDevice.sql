SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [ehr].[usp_SearchPatientImplantableDevice] 
	@PatientId	BIGINT,
	@DoctorCompanyId BIGINT,
	@FromDate DATETIME,
	@ToDate DATETIME
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
		PID.Source,
		PID.ManufacturedDate,
		PID.ExpirationDate,
		ID.ImplantableDeviceId,
		ID.BrandName,
		ID.DeviceId, PID.VisibilityHiddenToPatient 
	FROM 	[ehr].[PatientImplantableDevice] PID
			INNER JOIN [ehr].[ImplantableDevice] ID ON PID.ImplantableDeviceId=ID.ImplantableDeviceId
	WHERE 	PatientId=@PatientId AND DoctorCompanyId=@DoctorCompanyId
			AND ((@FromDate is null and @ToDate is null) OR 
				(PID.CreatedOn between @FromDate and @ToDate))

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
