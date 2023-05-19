SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--[ehr].[usp_GetCompanyAccessPreference] 1

CREATE PROCEDURE [ehr].[usp_GetCompanyApplicationConfiguration] 
(
	@DoctorCompanyId		BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
		SELECT AC.ConfigurationCode,
	   AT.Code,
	   AC.ConfigurationDescription,
	   CAC.CompanyApplicationConfigurationId,
	   AC.ApplicationConfigurationId,
	   ISNULL(CAC.ConfigurationValueId,AC.ConfigurationValueID) AS 'ConfigurationValueId',
	   ISNULL(ATC1.[Description], ATC.[Description]) AS 'ConfigurationValue'
	FROM ehr.ApplicationConfiguration					AC		WITH(NOLOCK)
	INNER JOIN ehr.[ApplicationTableConstants]		ATC     WITH(NOLOCK) ON ATC.ApplicationTableConstantId = AC.ConfigurationValueId
	INNER JOIN ehr.[ApplicationTables]		AT     WITH(NOLOCK) ON ATC.ApplicationTableId = AT.ApplicationTableId
	LEFT JOIN	ehr.[CompanyApplicationConfiguration]	CAC		WITH(NOLOCK)	ON	AC.[ApplicationConfigurationId] = CAC.[ApplicationConfigurationId] AND
																					CAC.DoctorCompanyId = @DoctorCompanyId AND
																					CAC.Active = 1
	LEFT JOIN ehr.[ApplicationTableConstants]		ATC1     WITH(NOLOCK) ON ATC1.ApplicationTableConstantId = CAC.ConfigurationValueId
	WHERE AC.Active = 1;


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
