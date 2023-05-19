SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 27.10.2017
-- Description: Load Social Hx Constants for Patient Encounter
-- =============================================
CREATE PROCEDURE  [enc].[usp_GetSocialHxConstantsForPatientEncounter]
AS

BEGIN
SET NOCOUNT ON;

	SELECT ATC.Description,ATC.Code,AT.Code as ApplicationTableCode, ATC.ApplicationTableConstantId,AT.ApplicationTableId from ehr.ApplicationTableConstants ATC 
	INNER JOIN ehr.ApplicationTables AT ON AT.ApplicationTableId = ATC.ApplicationTableId
	WHERE AT.Code IN ('SMOKE','FINRS','EDCAT','STRES','ALINT',
	'ALDAY','AL6RM','MARTL','CMSTS','EMTAB','AFRPT','RAPPT','KHSST')
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
