SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Afsal
-- Create date: 13-APRIL-2017
-- Description:	Search Drugs
-- Modified By:
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchDrugs]
	@DrugName		VARCHAR(80)
AS

BEGIN
	SET NOCOUNT ON;
	
	SELECT	DISTINCT MEDID,
			MED_MEDID_DESC
			
	FROM	rnmmidndc
	
	
	WHERE	(MED_MEDID_DESC LIKE @DrugName + '%'OR @DrugName IS NULL)
	ORDER BY
			MEDID DESC
	
			
				
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
