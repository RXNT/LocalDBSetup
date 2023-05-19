SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 16-Aug-2016
-- Description:	To Save Patient Immunization Registry Setting
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SavePatientImmunizationRegistrySettings]
	@PatientId INT,
	@ProtectionIndicator VARCHAR(1),
	@ProtectionIndicatorEffectiveDate DATETIME,
	@PublicityCode VARCHAR(2),
	@PublicityCodeEffectiveDate DATETIME,
	@RegistryStatus VARCHAR(1),
	@RegistryStatusEffectiveDate DATETIME,
	@EnteredBy INT,
	@DoctorId INT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM patient_immunization_registry_settings WHERE pa_id=@PatientId)
      UPDATE patient_immunization_registry_settings 
      SET protection_indicator=@ProtectionIndicator,
      protection_indicator_effective_date=@ProtectionIndicatorEffectiveDate, 
      publicity_code=@PublicityCode, 
      publicity_code_effective_date=@PublicityCodeEffectiveDate, 
      registry_status=@RegistryStatus, 
      registry_status_effective_date=@RegistryStatusEffectiveDate, 
      entered_by=@EnteredBy, 
      dr_id=@DoctorId, modified_on=GETDATE() 
      WHERE pa_id = @PatientId
    ELSE
      INSERT INTO patient_immunization_registry_settings 
      (protection_indicator,protection_indicator_effective_date,publicity_code,publicity_code_effective_date, 
      pa_id,registry_status,registry_status_effective_date,entered_by, dr_id ,entered_on) 
      VALUES 
      (@ProtectionIndicator,@ProtectionIndicatorEffectiveDate,@PublicityCode, @PublicityCodeEffectiveDate,
       @PatientId, @RegistryStatus,@RegistryStatusEffectiveDate, @EnteredBy, @DoctorId, GETDATE())
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
