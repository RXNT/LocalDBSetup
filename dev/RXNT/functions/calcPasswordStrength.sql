SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION calcPasswordStrength(@password VARCHAR(50))
  RETURNS INTEGER
AS
  BEGIN
    DECLARE @strength INTEGER, @index SMALLINT
    SET @index = 1
    SET @strength = 0
    WHILE (@index <= LEN(@password))
      BEGIN
        SET @strength = @strength + ASCII(SUBSTRING(@password, @index, 1))
        SET @index = @index + 1
      END
    RETURN @strength
  END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
