SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchConfigDetails]
  @category VARCHAR(100)  
AS 
BEGIN

	DECLARE @tempTable TABLE
	(
		[index] INT IDENTITY(1,1),
		[colname] VARCHAR(100)
	)

	DECLARE @iCount INT
	DECLARE @iIndex INT
	DECLARE @col VARCHAR(MAX)
	DECLARE @colName VARCHAR(MAX)
	SET @iIndex=1
	
	INSERT INTO @tempTable
	SELECT [KEY] FROM AppSettings 
	WHERE Category=@category
	SET @iCount=@@ROWCOUNT
	
	WHILE(@iIndex<=@iCount)
	BEGIN
		SELECT @col=colname FROM @tempTable WHERE [index]=@iIndex
		
		IF @colName is NULL
		BEGIN
			SET @colName=@col
		END
		ELSE
		BEGIN
			SET @colName=@colName+','+@col
		END
		SET @iIndex=@iIndex+1
	END
	DECLARE @query VARCHAR(MAX)
	SET @query ='SELECT '+@colName+'
	FROM (
		SELECT
	  
			[key] AS k, 
			Value AS v 
		FROM [AppSettings] 
	) as s
	PIVOT
	(
	   MAX([v])
		FOR k IN ('+@colName+')
	)AS pvt'
	
	EXECUTE(@query)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
