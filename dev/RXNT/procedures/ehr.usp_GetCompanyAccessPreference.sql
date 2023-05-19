SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--[ehr].[usp_GetCompanyAccessPreference] 1

CREATE PROCEDURE [ehr].[usp_GetCompanyAccessPreference]
(
	@DoctorCompanyId		BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT AC.PreferenceCode,
	   AT.Code, ATC.ApplicationTableId,
	   AC.PreferenceDescription,
	   CAC.CompanyAccessPreferenceId,
	   AC.AccessPreferenceId,
	    CAC.PreferenceValueId AS 'ConfigurationValueId',
	   ISNULL(ATC1.[Description], ATC.[Description]) AS 'ConfigurationValue'
	   
	FROM [RxNT].[ehr].[AccessPreference]			AC		WITH(NOLOCK)
	INNER JOIN [ehr].[ApplicationTableConstants]		ATC     WITH(NOLOCK) ON ATC.ApplicationTableConstantId = AC.PreferenceDataTypeId
	INNER JOIN [ehr].[ApplicationTables]		AT     WITH(NOLOCK) ON ATC.ApplicationTableId = AT.ApplicationTableId
	LEFT JOIN	[ehr].[CompanyAccessPreference]	CAC		WITH(NOLOCK)	ON	AC.AccessPreferenceId = CAC.AccessPreferenceId AND
																					CAC.DoctorCompanyId = @DoctorCompanyId AND
																					CAC.Active = 1
	LEFT JOIN [ehr].[ApplicationTableConstants]		ATC1     WITH(NOLOCK) ON ATC1.ApplicationTableConstantId = CAC.PreferenceValueId
	WHERE AC.Active = 1


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
