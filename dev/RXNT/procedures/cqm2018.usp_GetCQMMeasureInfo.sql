SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1-Feb-2018
-- Description:	To get Measure Infos
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_GetCQMMeasureInfo] 
	@NQFNumber VARCHAR(MAX) 
AS
BEGIN

	DECLARE @MeasureId BIGINT = 0
	SELECT @MeasureId = MeasureInfoId FROM cqm2018.SysLookupCqmMeasuresInfo WITH(NOLOCK) WHERE NQFNumber = @NQFNumber
	
	SELECT MeasureInfoId, MeasureTitle, ReferenceId, Description, MeasureNumber, NQFNumber
	FROM cqm2018.SysLookupCqmMeasuresInfo WITH(NOLOCK)
	WHERE MeasureInfoId = @MeasureId
	
	SELECT PopulationInfoId, MeasureInfoId, PopulationIndex, HasDenomException, HasDenomExclusion, ReferenceID, 
	IPP_ReferenceID, IPP_Description, DEN_ReferenceID, DEN_Description, NUM_ReferenceID, NUM_Description, 
	DEN_EXCL_ReferenceID, DEN_EXCL_Description, DEN_EXCP_ReferenceID, DEN_EXCP_Description
	FROM cqm2018.SysLookupCqmMeasurePopulationInfo WITH(NOLOCK)
	WHERE MeasureInfoId = @MeasureId
	ORDER BY PopulationIndex
	
	SELECT StratumInfoId, MeasureInfoId, PopulationInfoId, StratumIndex, IPP_ReferenceID, IPP_Description, 
	DEN_ReferenceID, DEN_Description, NUM_ReferenceID, NUM_Description, DEN_EXCL_ReferenceID, DEN_EXCL_Description,
	DEN_EXCP_ReferenceID, DEN_EXCP_Description
	FROM cqm2018.SysLookupCqmMeasureStratumInfo WITH(NOLOCK)
	WHERE MeasureInfoId = @MeasureId 
	ORDER BY PopulationInfoId, StratumIndex

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
