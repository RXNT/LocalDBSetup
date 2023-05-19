SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	Delete patient implantable device
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [phr].[usp_DeletePatientImplantableDevice]
	@PatientImplantableDeviceId BIGINT,
	@PatientId BIGINT,
	@DoctorCompanyId BIGINT
AS
BEGIN
	UPDATE [ehr].[PatientImplantableDeviceExternal]
	SET Active = 0
	WHERE PatientImplantableDeviceExtId=@PatientImplantableDeviceId 
	AND PatientId=@PatientId 
	AND DoctorCompanyId=@DoctorCompanyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
