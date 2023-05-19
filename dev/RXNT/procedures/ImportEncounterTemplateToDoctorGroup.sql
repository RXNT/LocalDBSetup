SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: April 11, 2018
-- Description:	Import Encounter Template To Doctor Group
-- =============================================
CREATE PROCEDURE [dbo].[ImportEncounterTemplateToDoctorGroup]
(
	-- Add the parameters for the stored procedure here
	@TemplateId			BIGINT,
	@IsRxNTEncounter	BIT = NULL,
	@DoctorGroupId		BIGINT,
	@DoctorId			BIGINT,
	@FromDoctorId		BIGINT=0
)
AS
BEGIN
	IF(ISNULL(@TemplateId,0)>0 AND @IsRxNTEncounter IS NOT NULL)
	BEGIN
		IF (@IsRxNTEncounter = 1)
		BEGIN
			IF NOT EXISTS( SELECT TOP 1 1 FROM doc_group_enhanced_encounter_templates WHERE dg_id=@DoctorGroupId AND import_ref_id=@TemplateId)
			BEGIN
				INSERT INTO doc_group_enhanced_encounter_templates (dg_id,added_by_dr_id,chief_complaint,enc_text,enc_name,enc_json,import_ref_id,import_date)
				SELECT TOP 1 @DoctorGroupId,@DoctorId,chief_complaint,enc_text,enc_name,enc_json,@TemplateId,GETDATE()
				FROM enchanced_encounter_templates WITH(NOLOCK)
				WHERE enc_tmpl_id=@TemplateId AND dr_id=@FromDoctorId
			END
		END
		ELSE IF (@IsRxNTEncounter = 0)
		BEGIN
			IF NOT EXISTS( SELECT TOP 1 1 FROM doc_group_encounter_templates WHERE dg_id=@DoctorGroupId AND import_ref_id=@TemplateId)
			BEGIN
				INSERT INTO doc_group_encounter_templates (dg_id,added_by_dr_id,enc_type_id,enc_name,enc_text,enc_json,import_ref_id,import_date)
				SELECT TOP 1 @DoctorGroupId,@DoctorId,enc_type_id,enc_name,enc_text,enc_json,@TemplateId,GETDATE()
				FROM encounter_templates WITH(NOLOCK)
				WHERE enc_tmpl_id=@TemplateId AND dr_id=@FromDoctorId
			END
		END
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
