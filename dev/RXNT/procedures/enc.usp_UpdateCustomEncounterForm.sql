SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 18-Mar-2016
-- Description:	To get the custom encounter form
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_UpdateCustomEncounterForm]
	@FormID BIGINT,
	@JsonDefinition NVARCHAR(MAX)
AS

BEGIN
	SET NOCOUNT ON;

	UPDATE emd SET json_definition = @JsonDefinition
	FROM encounter_model_definitions emd WITH(NOLOCK)
	INNER JOIN encounter_types et WITH(NOLOCK) ON emd.type = et.enc_type 
	INNER JOIN encounter_form_settings efs WITH(NOLOCK) ON et.enc_type =efs.type
	WHERE efs.enc_type_id = @FormID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
