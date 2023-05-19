SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Ramakrishna
-- Create date: 	02-Jan-2017
-- Description:		Copy Doctor RxNT Encounter Templates
-- =============================================
CREATE PROCEDURE [support].[CopyDoctorRxNTEncounterTemplates]
  @FromDoctorId BIGINT,
  @ToDoctorId BIGINT   
AS
BEGIN

	IF @FromDoctorId > 0 AND @ToDoctorId > 0
	BEGIN
		UPDATE eet_to 
		SET [chief_complaint] = eet_from.[chief_complaint]
			,[enc_text] =eet_from.[enc_text]
			,[enc_json] = eet_from.[enc_json] 
		FROM enchanced_encounter_templates eet_from WITH(NOLOCK) 
		INNER JOIN enchanced_encounter_templates eet_to WITH(NOLOCK) ON eet_to.dr_id =@ToDoctorId AND eet_from.enc_name = eet_to.enc_name 
		WHERE eet_from.dr_id = @FromDoctorId
		  				
		  				
		INSERT INTO [dbo].[enchanced_encounter_templates]
           ([dr_id]
           ,[chief_complaint]
           ,[enc_text]
           ,[enc_name]
           ,[enc_json]) 
		SELECT  @ToDoctorId
		  ,eet_from.[chief_complaint]
		  ,eet_from.[enc_text]
		  ,eet_from.[enc_name]
		  ,eet_from.[enc_json] 
			FROM enchanced_encounter_templates eet_from WITH(NOLOCK) 
			LEFT OUTER JOIN enchanced_encounter_templates eet_to WITH(NOLOCK) ON eet_to.dr_id =@ToDoctorId AND eet_from.enc_name = eet_to.enc_name 
		WHERE eet_from.dr_id = @FromDoctorId AND eet_to.enc_tmpl_id IS NULL
	END	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
