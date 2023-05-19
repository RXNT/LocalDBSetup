SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 28-Oct-2016
-- Description:	To get the encounter information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetEncounterInfo]
	@EncounterId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	 select enc_id, 
	 patient_id,
	 dr_id,
	 enc_date,
	 type,
	 encounter_version
	 from enchanced_encounter with(nolock) where enc_id = @EncounterId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
