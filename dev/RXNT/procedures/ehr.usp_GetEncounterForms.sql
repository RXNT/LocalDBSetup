SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [ehr].[usp_GetEncounterForms]  
	@DoctorId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	 IF EXISTS(SELECT TOP 1 1 FROM [encounter_form_settings] efs WITH(NOLOCK) WHERE DR_ID = @DoctorId)
	 BEGIN
		SELECT efs.ENC_TYPE_ID, efs.name, efs.TYPE, efs.sort_order, et.encounter_version , et.enc_lst_id, et.speciality
		FROM [encounter_form_settings] efs WITH(NOLOCK) 
		INNER JOIN [encounter_types] et WITH(NOLOCK) ON et.enc_type = efs.type
		WHERE DR_ID = @DoctorId
		ORDER BY efs.sort_order ASC
	END
	ELSE IF NOT EXISTS(SELECT * FROM doc_companies dc WITH(NOLOCK) INNER JOIN doc_groups dg WITH(NOLOCK) ON dc.dc_id=dg.dc_id INNER JOIN doctors dr WITH(NOLOCK) ON dr.dg_id=dg.dg_id WHERE dr.dr_id=@DoctorId AND dc.EnableV2EncounterTemplate=1)
	BEGIN
		SELECT 1 AS ENC_TYPE_ID,'RxNT Encounter' AS name, 'RxNTEncounterModels.EnhancedPatientEncounter' TYPE, 1 sort_order, 'v1.1' encounter_version,NULL enc_lst_id,NULL speciality
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
