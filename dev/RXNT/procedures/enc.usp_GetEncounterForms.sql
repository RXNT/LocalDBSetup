SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 28-Jan-2016
-- Description:	To get the encounter forms
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetEncounterForms] 
	@DoctorId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT TOP 1 1 FROM [encounter_form_settings] efs WITH(NOLOCK) WHERE DR_ID = @DoctorId)
	 BEGIN
		SELECT efs.ENC_TYPE_ID, efs.name, efs.TYPE, et.encounter_version ,et.enc_lst_id,et.speciality
		FROM [encounter_form_settings] efs WITH(NOLOCK) 
		INNER JOIN [encounter_types] et WITH(NOLOCK) ON et.enc_type = efs.type
		WHERE DR_ID = @DoctorId
		ORDER BY efs.name
	END
	ELSE
	BEGIN
		SELECT 1 AS ENC_TYPE_ID,'RxNT Encounter' AS name, 'RxNTEncounterModels.EnhancedPatientEncounter' TYPE, 'v1.1' encounter_version,null enc_lst_id,NULL speciality
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
