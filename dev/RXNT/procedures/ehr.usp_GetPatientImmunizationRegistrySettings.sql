SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 16-Aug-2016
-- Description:	To Get Patient Immunization Registry Setting
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPatientImmunizationRegistrySettings]
	@PatientId INT
AS
BEGIN
	select [pa_id],protection_indicator,protection_indicator_effective_date,[publicity_code],[publicity_code_effective_date],[registry_status],[registry_status_effective_date],[entered_by],[dr_id],[entered_on],[modified_on] 
	from patient_immunization_registry_settings 
	where pa_id = @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
