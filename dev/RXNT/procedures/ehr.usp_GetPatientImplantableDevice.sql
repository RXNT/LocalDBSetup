SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 12-October-2017
-- Description:	Get patient implantable device
-- Modified By: Samip Neupane
-- Modified Date: 12/14/2022
-- =============================================
CREATE   PROCEDURE [ehr].[usp_GetPatientImplantableDevice] 
	@PatientId	BIGINT,
	@DoctorCompanyId BIGINT,
	@PatientImplantableDeviceId BIGINT
AS
BEGIN
	SELECT 
		PID.PatientImplantableDeviceId,
		PID.DoctorCompanyId,
		PID.PatientId,
		PID.CreatedOn,
		PID.BatchNumber,
		PID.LotNumber,
		PID.SerialNumber,
		PID.ManufacturedDate,
		PID.ExpirationDate,
		PID.CreatedOn,
		PID.Active,
		ID.ImplantableDeviceId,
		ID.BrandName,
		ID.DeviceId
	FROM [ehr].[PatientImplantableDevice] PID WITH(NOLOCK)
	INNER JOIN [ehr].[ImplantableDevice] ID WITH(NOLOCK) ON PID.ImplantableDeviceId=ID.ImplantableDeviceId
	WHERE PID.PatientId=@PatientId AND PID.DoctorCompanyId=@DoctorCompanyId
	AND PID.PatientImplantableDeviceId=@PatientImplantableDeviceId
	

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
