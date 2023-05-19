SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 19-Jul-2016
-- Description:	Delete  Medical Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatientMedicalHx]
	@MedicalHxId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	DELETE FROM patient_medical_hx 
	WHERE pat_id=@PatientId AND medhxid=@MedicalHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
