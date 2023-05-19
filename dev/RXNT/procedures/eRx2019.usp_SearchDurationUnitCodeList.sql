SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 03/02/2020
-- Description: Fetch all DurationUnitCodes
-- Modified By : 
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [eRx2019].[usp_SearchDurationUnitCodeList]
@DurationUnitCodeArray AS XML
 
AS  

  BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT A.potency_unit_code DurationUnitCode, A.du_text DurationUnit
	FROM duration_units A WITH(NOLOCK) 
	INNER JOIN @DurationUnitCodeArray.nodes('/ArrayOfString/string') AS x ( y ) ON x.y.value('.','VARCHAR(50)')=A.potency_unit_code 
	--WHERE A.NDC IN (" + strNdcList + "
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
