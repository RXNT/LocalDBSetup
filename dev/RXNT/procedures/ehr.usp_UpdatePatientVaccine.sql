SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 12-Aug-2016
-- Description:	To update patient vaccine
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpdatePatientVaccine]
	@VaccineRecordId INT,
	@VaccineId INT,
	@VaccineName VARCHAR(150)
AS
BEGIN

	UPDATE tblVaccinationRecord
	SET vac_name = @VaccineName,
	vac_id = @VaccineId
	WHERE vac_rec_id = @VaccineRecordId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
