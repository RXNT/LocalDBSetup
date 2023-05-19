SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: kalimuthu S
-- Create date	: 06-MAY-20120
-- Description	: Get the V2 patient Id
-- =============================================
CREATE PROCEDURE [dbo].[GetV2PatientId]
(	
	@PATID INT
)
AS
BEGIN
	DECLARE @PatientId VARCHAR(100) = CAST(@PATID AS VARCHAR(100))
	SELECT
		mp.PatientId
	FROM
		[dbo].[RsynMasterPatients] mp WITH(NOLOCK)
		INNER JOIN [dbo].[RsynMasterPatientExternalAppMaps] mpea WITH(NOLOCK) ON mp.PatientId = mpea.PatientId
	WHERE
		mpea.ExternalPatientId = @PatientId
		AND mpea.ExternalAppId = 1;		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
