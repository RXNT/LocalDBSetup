SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.spRebuildIndexes (@ONLY_SCHEMA_NAME NVARCHAR(50))
AS
BEGIN
	DECLARE @SCHEMA_NAME VARCHAR(50)
	DECLARE @TABLE_NAME VARCHAR(255)
	DECLARE @SQL NVARCHAR(4000)

	DECLARE TABLES_CUR CURSOR FORWARD_ONLY READ_ONLY LOCAL FOR
		SELECT S.name AS sname, T.name AS tname 
		FROM sys.tables T 
		INNER JOIN sys.schemas S ON T.schema_id = S.schema_id 
		WHERE T.type = 'U'
		AND S.name = CASE WHEN @ONLY_SCHEMA_NAME IS NULL THEN S.name ELSE @ONLY_SCHEMA_NAME END 

	OPEN TABLES_CUR
	FETCH NEXT FROM TABLES_CUR INTO @SCHEMA_NAME, @TABLE_NAME

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @SQL = 'ALTER INDEX ALL ON ' + @SCHEMA_NAME + '.' + @TABLE_NAME + ' REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = OFF)'
		PRINT @SQL
		EXECUTE sp_executesql @statement = @SQL
		FETCH NEXT FROM TABLES_CUR INTO @SCHEMA_NAME, @TABLE_NAME
	END

	CLOSE TABLES_CUR
	DEALLOCATE TABLES_CUR
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
