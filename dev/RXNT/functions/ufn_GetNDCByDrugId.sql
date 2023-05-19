SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_GetNDCByDrugId] 
( 
    @DrugId BIGINT
) 
RETURNS VARCHAR(50)
BEGIN 
	DECLARE @NDC VARCHAR(50) 
	SELECT TOP 1  @NDC=a.NDC
	FROM rnmmidndc a WITH(NOLOCK)
	WHERE a.MEDID=@DrugId AND a.OBSDTEC IS NULL
    RETURN  @NDC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO