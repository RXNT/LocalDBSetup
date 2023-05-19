SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[getUTCDateTime] 
( 
    @dt DATETIME      
) 
RETURNS DATETIME 
AS 
BEGIN 
    SELECT TOP 1 @dt = DATEADD(HOUR, UTCOffset, @dt) 
        FROM Calendar WITH (NOLOCK) 
        WHERE dt <= @dt 
        ORDER BY dt DESC 
 
    RETURN @dt 
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
