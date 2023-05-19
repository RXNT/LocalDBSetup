SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[RebuildAllIndices]
AS
  DECLARE 
    @strIndex VARCHAR(100),
    @strTable VARCHAR(100),
    @strOldTable VARCHAR(100)

  DECLARE curIndexes CURSOR
  READ_ONLY
  FOR 
    SELECT i.name, o.name FROM sysindexes i INNER JOIN sysobjects o ON o.id = i.id WHERE type = 'U'

  OPEN curIndexes

  FETCH NEXT FROM curIndexes INTO @strIndex, @strTable
  WHILE (@@fetch_status <> -1)
  BEGIN
    IF @strOldTable <> @strTable 
      DBCC dbreindex  (@strTable, '', 70)
    SET @strOldTable = @strTable
    FETCH NEXT FROM curIndexes INTO @strIndex, @strTable
  END

  CLOSE curIndexes
  DEALLOCATE curIndexes
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
