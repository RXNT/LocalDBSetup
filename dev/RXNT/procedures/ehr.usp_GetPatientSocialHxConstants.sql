SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6.09.2017
-- Description: Load Social Hx Constants
-- Last Modified By	:   Tucker Weed
-- Description			:	Load SNOMED Code
-- Last Modifed Date	:	22-March-2023
-- =============================================
CREATE   PROCEDURE   [ehr].[usp_GetPatientSocialHxConstants]
AS

BEGIN
SET NOCOUNT ON;

	SELECT ATC.Description,ATC.Code,AT.Code as ApplicationTableCode, 
	ATC.ApplicationTableConstantId, AT.ApplicationTableId, SLC.Code as SNOMED,
	ATC.SortOrder
	from ehr.ApplicationTableConstants ATC WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATC.ApplicationTableId
	left join ehr.SysLookupCodes SLC WITH(NOLOCK) ON SLC.ApplicationTableConstantCode = ATC.Code  AND ATC.ApplicationTableConstantId = SLC.ApplicationTableConstantId
	WHERE AT.Code IN ('SMOKE','FINRS','EDCAT','STRES','ALINT',
	'ALDAY','AL6RM','MARTL','CMSTS','EMTAB','AFRPT','RAPPT','KHSST','MULBR')
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
