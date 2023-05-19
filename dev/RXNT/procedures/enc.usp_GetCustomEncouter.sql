SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author:		Thomas K
-- Create date: 31-Jan-2016
-- Description:	To get the CustomEncounter Details
-- Modified By: 
-- Modified Date: 
-- ====================================================
CREATE PROCEDURE [enc].[usp_GetCustomEncouter]
	@PatientID BIGINT,
	@EncounterID BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT enc_text,ENCJ.JSON,ENCX.issigned,ENCJ.type,ET.enc_name,ENCX.is_released
	FROM enchanced_encounter ENCX WITH(NOLOCK) 
	LEFT OUTER JOIN [enchanced_encounter_additional_info] ENCJ WITH(NOLOCK) ON ENCX.enc_id = ENCJ.enc_id
	LEFT OUTER JOIN encounter_types ET WITH(NOLOCK) ON ET.enc_type = ENCJ.type
	WHERE ENCX.enc_id = @EncounterID AND ENCX.patient_id = @PatientID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
