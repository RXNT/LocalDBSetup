SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetDrugStrengthUnitCode] 
( 
    @StrengthName VARCHAR(50)
) 
RETURNS VARCHAR(50)
BEGIN 
	DECLARE @Code VARCHAR(100) 
	SELECT TOP 1 @Code=su.NCIt_unit_code 
	FROM [dbo].[drug_fdb_strength_units] fsu WITH(NOLOCK) 
	INNER JOIN [drug_strength_units] su WITH(NOLOCK) ON fsu.dsu_id=su.dsu_id
	WHERE fsu.dsu_text =@StrengthName
    RETURN  ISNULL(@Code,'C38046')
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
