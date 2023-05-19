SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Ramakrishna
-- Create date: 	02-Jan-2017
-- Description:		Copy Doctor Custom Encounter Templates
-- =============================================
CREATE PROCEDURE [support].[CopyDoctorCustomEncounterTemplates]
  @FromDoctorId				BIGINT,
  @ToDoctorId				BIGINT, 
  @EncounterFormName		VARCHAR(100) = NULL
AS
BEGIN
	DECLARE @ModelDefintionId BIGINT = 0
	-- DECLARE @Type VARCHAR(100)
	
	IF @EncounterFormName IS NOT NULL
	BEGIN
		SELECT @ModelDefintionId=emd.model_defn_id
		FROM encounter_model_definitions emd
		INNER JOIN encounter_types et With(NOLOCK) ON et.enc_type = emd.type AND et.enc_name=@EncounterFormName
	END
	
	
	/*SELECT @Type = enc_type
	FROM encounter_types WITH(NOLOCK)
	WHERE enc_name = @EncounterFormName
	
	SELECT @ModelDefintionId=model_defn_id 
	FROM encounter_model_definitions WITH(NOLOCK)
	WHERE type = @Type*/
	
	IF @FromDoctorId > 0 AND @ToDoctorId > 0
	BEGIN
		UPDATE eet_to 
		SET [enc_text] =eet_from.[enc_text]
			,[enc_json] = eet_from.[enc_json] 
		FROM [encounter_templates] eet_from WITH(NOLOCK) 
		INNER JOIN [encounter_templates] eet_to WITH(NOLOCK) ON eet_to.dr_id =@ToDoctorId AND eet_to.enc_type_id = eet_from.enc_type_id AND eet_from.enc_name = eet_to.enc_name 
		WHERE eet_from.dr_id = @FromDoctorId AND (@EncounterFormName IS  NULL OR  eet_from.enc_type_id = @ModelDefintionId )
		
    				
		INSERT INTO [dbo].[encounter_templates]
           ([dr_id]
           ,[enc_type_id]
           ,[enc_name]
           ,[enc_text]
           ,[enc_json]) 
		SELECT  @ToDoctorId
		  ,eet_from.[enc_type_id]
		  ,eet_from.[enc_name]
		  ,eet_from.[enc_text]
		  ,eet_from.[enc_json] 
			FROM [encounter_templates] eet_from  WITH(NOLOCK) 
			LEFT OUTER JOIN [encounter_templates] eet_to WITH(NOLOCK) ON eet_to.dr_id =@ToDoctorId AND eet_to.enc_type_id = eet_from.enc_type_id AND eet_from.enc_name = eet_to.enc_name 
		WHERE eet_from.dr_id = @FromDoctorId AND (@EncounterFormName IS  NULL OR  eet_from.enc_type_id = @ModelDefintionId) AND eet_to.enc_tmpl_id IS NULL
	END	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
