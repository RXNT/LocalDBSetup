SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPotencyUnitByCode] 
( 
    @PotencyUnitCode VARCHAR(50)
) 
RETURNS VARCHAR(50)
BEGIN 
	DECLARE @PotencyUnit VARCHAR(100) 
	SELECT TOP 1 @PotencyUnit=du_text FROM duration_units WHERE potency_unit_code =@PotencyUnitCode
    RETURN  @PotencyUnit
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
