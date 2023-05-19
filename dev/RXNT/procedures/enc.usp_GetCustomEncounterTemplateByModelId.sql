SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 24-NOV-2017
-- Description:	To get the custom encounter form
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetCustomEncounterTemplateByModelId] 
	@EncounterModelId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT emd.definition,emd.json_definition
	FROM encounter_model_definitions emd WITH(NOLOCK)
	WHERE emd.model_defn_id = @EncounterModelId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
