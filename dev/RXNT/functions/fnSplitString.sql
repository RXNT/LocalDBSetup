SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[fnSplitString] 
( 
    @string NVARCHAR(MAX), 
    @delimiter CHAR(1),
    @pos int
) 
RETURNS NVARCHAR(MAX) 
BEGIN 
	DECLARE @output NVARCHAR(MAX)
	DECLARE @tTable TABLE(id INT , splitdata NVARCHAR(MAX))
    DECLARE @start INT, @end INT , @iRow INT
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    SET @iRow = 0
    WHILE @start < LEN(@string) + 1 BEGIN 
		SET @iRow = @iRow + 1
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @tTable (id,splitdata)  
        VALUES(@iRow,SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 
    select @output=splitdata from @tTable where id =  @pos
    RETURN @output;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
