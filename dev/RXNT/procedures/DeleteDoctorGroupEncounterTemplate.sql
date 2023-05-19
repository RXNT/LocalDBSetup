SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: April 11, 2018
-- Description:	Delete Doctor Group Encounter Template
-- =============================================
CREATE PROCEDURE [dbo].[DeleteDoctorGroupEncounterTemplate]
(
	-- Add the parameters for the stored procedure here
	@TemplateId			BIGINT,
	@IsRxNTEncounter	BIT = NULL,
	@DoctorGroupId		BIGINT
)
AS
BEGIN
	IF(ISNULL(@TemplateId,0)>0 AND @IsRxNTEncounter IS NOT NULL)
	BEGIN
		IF (@IsRxNTEncounter = 1)
		BEGIN
			DELETE FROM doc_group_enhanced_encounter_templates
			WHERE enc_tmpl_id=@TemplateId AND dg_id=@DoctorGroupId
		END
		ELSE IF (@IsRxNTEncounter = 0)
		BEGIN
			DELETE FROM doc_group_encounter_templates
			WHERE enc_tmpl_id=@TemplateId AND dg_id=@DoctorGroupId
		END
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
