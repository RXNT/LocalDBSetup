SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION NEW_TIME 
	(@DT AS DATETIME, 
	 @TZ1 AS VARCHAR(12),
	 @TZ2 AS VARCHAR(12))
RETURNS DATETIME
AS
BEGIN
	-- Declare variables
	DECLARE @NEWDT AS DATETIME
	
	-- Check to see if the provided timezone for the source datetime is in GMT or UTC time
	-- If it is not then convert the provided datetime to UTC time
	IF NOT @TZ1 IN ('GMT','UTC')
	BEGIN
		SELECT @NEWDT = dbo.GET_UTCTIME(@DT,@TZ1)
	END
	ELSE
	-- If the provided datetime is in UTC or GMT time then set the NEWTIME variable to this value
	BEGIN
		SET @NEWDT = @DT
	END

	-- Check to see if the provided conversion timezone is GMT or UTC
	-- If it is then no conversion is needed.
	-- If it is not then convert the provided datetime to the desired timezone
	IF NOT @TZ2 IN ('GMT','UTC')
	BEGIN
		SELECT @NEWDT = dbo.GET_TZTIME(@NEWDT,@TZ2)
	END

	-- Return the new converted datetime
	RETURN @NEWDT
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
