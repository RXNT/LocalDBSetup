SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author			:	Nambi
-- Created date		:	18-OCT-2018
-- Description		:	Get Patient Detailed Races
-- =============================================
CREATE PROCEDURE  [phr].[usp_GetPatientDetailedRaces]
 	@PatientId			BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT PA_RACE_ID, PA_ID, A.RACE_ID, RACE_TEXT, dr_id, date_added, 
	B.Description,B.Code
	FROM patient_race_details A WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTableConstants B WITH(NOLOCK) ON A.RACE_ID = B.ApplicationTableConstantId
	WHERE A.PA_ID = @PatientId 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
