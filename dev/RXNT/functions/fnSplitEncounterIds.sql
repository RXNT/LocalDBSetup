SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[fnSplitEncounterIds] 
( 
    @encIds NVARCHAR(MAX), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(splitEncIds NVARCHAR(MAX) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @encIds) 
    WHILE @start < LEN(@encIds) + 1 BEGIN 
   
        IF @end = 0  
            SET @end = LEN(@encIds) + 1
       
        INSERT INTO @output (splitEncIds)  
        VALUES(SUBSTRING(@encIds, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @encIds, @start)
        
    END 
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
