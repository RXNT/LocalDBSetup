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
CREATE  PROCEDURE [eRx2019].[usp_GetDrugQuanityUnitDetails]
@Unit AS VARCHAR(50)
 
AS  

  BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT A.potency_unit_code PotencyUnitCode, A.du_text Unit
	FROM duration_units A WITH(NOLOCK) 
	WHERE A.du_text=@Unit
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
