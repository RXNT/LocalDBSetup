SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 18-JULY-2017
-- Description:	To get the custom encounter form type
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetCustomEncounterFormById]
	@TypeID BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	
	SELECT emd.definition,emd.json_definition
	FROM encounter_model_definitions emd WITH(NOLOCK)
	INNER JOIN encounter_types et WITH(NOLOCK) ON emd.type = et.enc_type
	WHERE et.enc_lst_id=@TypeID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
