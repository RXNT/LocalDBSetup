SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   PROCEDURE [enc].[usp_GetPatientSocialHxConstantsForPatientEncounter]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ATC.Description,
		ATC.Code,
		AT.Code AS ApplicationTableCode,
		ATC.ApplicationTableConstantId,
		AT.ApplicationTableId,
		ATC.SortOrder
	FROM ehr.ApplicationTableConstants ATC WITH (NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH (NOLOCK) ON AT.ApplicationTableId = ATC.ApplicationTableId
	WHERE AT.Code IN (
			'SMOKE',
			'FINRS',
			'EDCAT',
			'STRES',
			'ALINT',
			'ALDAY',
			'AL6RM',
			'MARTL',
			'CMSTS',
			'EMTAB',
			'AFRPT',
			'RAPPT',
			'KHSST'
			)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
