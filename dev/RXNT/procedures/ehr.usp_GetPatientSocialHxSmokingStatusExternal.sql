SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 26-2-2018
-- Description:	To get the patient Social Hx Smoking Status External
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPatientSocialHxSmokingStatusExternal]    
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT 
	pssd.PatientSmokingStatusDetailExtId, 
		pssd.PatientId as PatientId,
		ATS.Code as Code,
		ATS.Description as Description,
		pssd.StartDate,
		pssd.EndDate,
		pssd.Active,
		pssd.SmokingStatusCode
	FROM ehr.PatientSmokingStatusDetailExternal pssd 
	INNER JOIN ehr.ApplicationTableConstants ATS ON CONVERT(VARCHAR(12), pssd.SmokingStatusCode) = ATS.Code
	INNER JOIN ehr.ApplicationTables AT ON AT.ApplicationTableId=ATS.ApplicationTableId
	WHERE pssd.PatientId= @PatientId AND  AT.Code='SMOKE'
	ORDER BY pssd.PatientSmokingStatusDetailExtId DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
