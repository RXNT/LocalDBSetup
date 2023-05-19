SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [enc].[usp_DeletePatientImplantableDeviceFromPatientEncounter]
	@PatientImplantableDeviceId BIGINT,
	@PatientId BIGINT,
	@DoctorCompanyId BIGINT
AS
BEGIN
	DELETE FROM [ehr].[PatientImplantableDevice]
	WHERE PatientImplantableDeviceId=@PatientImplantableDeviceId 
	AND PatientId=@PatientId 
	AND DoctorCompanyId=@DoctorCompanyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
