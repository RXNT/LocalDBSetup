SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 12-October-2017
-- Description:	Delete patient implantable device
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatientImplantableDevice]
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
