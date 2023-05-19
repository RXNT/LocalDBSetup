SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 8-Aug-2016
-- Description:	To Search Patient External Active Mes
-- Mod1ified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchPatientExternalActiveMeds]
  @PatientId INT
AS
BEGIN
	SELECT pame_id, pame_pa_id, pame_drug_id, pame_date_added, pame_compound, pame_comments, pame_status,
	pame_drug_name, pame_dosage, pame_duration_amount, pame_duration_unit, pame_drug_comments, pame_numb_refills,
	pame_use_generic, pame_days_supply, pame_prn, pame_prn_description, pame_date_start, pame_date_end, pame_source_name,
	active, last_modified_by, last_modified_date, external_id,rxnorm_code
	FROM patient_active_meds_external WITH(NOLOCK)
	WHERE pame_pa_id = @PatientId 
	ORDER BY pame_date_added desc, pame_source_name asc
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
