SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 29-DEC-2022
-- Description:	To get Measure Infos
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_GetCQMMeasureInfo] 
	@NQFNumber VARCHAR(MAX) 
AS
BEGIN

	DECLARE @MeasureId BIGINT = 0
	SELECT @MeasureId = MeasureInfoId FROM cqm2022.SysLookupCqmMeasuresInfo WITH(NOLOCK) WHERE NQFNumber = @NQFNumber
	
	SELECT MeasureInfoId, MeasureTitle, ReferenceId, Description, MeasureNumber, NQFNumber, SetID
	FROM cqm2022.SysLookupCqmMeasuresInfo WITH(NOLOCK)
	WHERE MeasureInfoId = @MeasureId
	
	SELECT PopulationInfoId, MeasureInfoId, PopulationIndex, HasDenomException, HasDenomExclusion, ReferenceID, 
	IPP_ReferenceID, IPP_Description, DEN_ReferenceID, DEN_Description, NUM_ReferenceID, NUM_Description, 
	DEN_EXCL_ReferenceID, DEN_EXCL_Description, DEN_EXCP_ReferenceID, DEN_EXCP_Description
	FROM cqm2022.SysLookupCqmMeasurePopulationInfo WITH(NOLOCK)
	WHERE MeasureInfoId = @MeasureId
	ORDER BY PopulationIndex
	
	SELECT StratumInfoId, MeasureInfoId, PopulationInfoId, StratumIndex, IPP_ReferenceID, IPP_Description, 
	DEN_ReferenceID, DEN_Description, NUM_ReferenceID, NUM_Description, DEN_EXCL_ReferenceID, DEN_EXCL_Description,
	DEN_EXCP_ReferenceID, DEN_EXCP_Description
	FROM cqm2022.SysLookupCqmMeasureStratumInfo WITH(NOLOCK)
	WHERE MeasureInfoId = @MeasureId 
	ORDER BY PopulationInfoId, StratumIndex

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
