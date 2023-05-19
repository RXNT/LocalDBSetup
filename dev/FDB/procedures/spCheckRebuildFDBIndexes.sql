SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[spCheckRebuildFDBIndexes] 
AS
BEGIN
	DECLARE @SCHEMA_NAME VARCHAR(50)

	SELECT @SCHEMA_NAME = fdb_schema_next_name 
	FROM dbo.fdb_schema_current 
	WHERE fdb_schema_next_need_index_rebuild = 1
	AND fdb_schema_next_has_errors = 0 
	
	IF NOT @SCHEMA_NAME IS NULL BEGIN
		PRINT 'Rebuilding indexes on schema ' + @SCHEMA_NAME
		EXEC dbo.spRebuildIndexes @ONLY_SCHEMA_NAME = @SCHEMA_NAME
		UPDATE dbo.fdb_schema_current SET fdb_schema_next_need_index_rebuild = 0 WHERE fdb_schema_current_id = 1
		PRINT 'Done rebuilding indexes on schema ' + @SCHEMA_NAME
	END ELSE BEGIN
		PRINT 'Nothing to rebuild'
	END
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
