SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: April 1, 2018
-- Description:	List Encounter Settings For Doctor Group
-- =============================================
CREATE PROCEDURE [dbo].[ListEncounterSettingsForDoctorGroup]
(
	-- Add the parameters for the stored procedure here
	@DoctorGroupId			INT,
	@LoadOnlyDoctorGroup	BIT = 1	
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF(ISNULL(@LoadOnlyDoctorGroup,0) = 1)
	BEGIN
		WITH EncounterForms AS (
			SELECT C.ENC_TYPE_ID,C.dr_id, C.name, C.TYPE, ROW_NUMBER() OVER(PARTITION BY C.name ORDER BY C.name DESC) as RN 
			FROM doc_group_encounter_templates A WITH(NOLOCK)
			INNER JOIN encounter_model_definitions B WITH(NOLOCK) ON A.enc_type_id=B.model_defn_id
			INNER JOIN [encounter_form_settings] C WITH(NOLOCK) ON C.type = B.type
			WHERE A.dg_id=@DoctorGroupId
		)

		SELECT * FROM EncounterForms WHERE RN=1
	END
	ELSE
	BEGIN
		WITH EncounterForms AS (
			SELECT efs.ENC_TYPE_ID,efs.dr_id, efs.name, efs.TYPE, ROW_NUMBER() OVER(PARTITION BY efs.name ORDER BY efs.name DESC) as RN FROM [encounter_form_settings] efs with(nolock)
			INNER JOIN [encounter_types] et WITH(NOLOCK) ON et.enc_type = efs.type
			INNER JOIN doctors dr WITH(NOLOCK) ON efs.dr_id=dr.dr_id
			WHERE dr.dg_id=@DoctorGroupId
		)

		SELECT * FROM EncounterForms WHERE RN=1
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
