SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION GET_UTCTIME 
	(@DT AS DATETIME, 
	 @TZ AS VARCHAR(12))
RETURNS DATETIME
AS
BEGIN
-- DECLARE VARIABLES
	DECLARE @NEWDT AS DATETIME
	DECLARE @OFFSETHR AS INT
	DECLARE @OFFSETMI AS INT
	DECLARE @DSTOFFSETHR AS INT
	DECLARE @DSTOFFSETMI AS INT
	DECLARE @DSTDT AS VARCHAR(10)
	DECLARE @DSTEFFDT AS VARCHAR(10)
	DECLARE @DSTENDDT AS VARCHAR(10)
	
-- GET THE DST parameter from the provided datetime
	-- This gets the month of the datetime provided (2 char value)
	SELECT @DSTDT = CASE LEN(DATEPART(month, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(month, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(month, @DT)) END
	-- This gets the occurance of the day of the week within the month (i.e. first sunday, or second sunday...) (1 char value)
	SELECT @DSTDT = @DSTDT + CONVERT(VARCHAR(1),(DATEPART(day,@DT) + 6) / 7)
	-- This gets the day of the week for the provided datetime (1 char value)
	SELECT @DSTDT = @DSTDT + CONVERT(VARCHAR(1),DATEPART(dw, @DT))
	-- This gets the hour for the provided datetime (2 char value)
	SELECT @DSTDT = @DSTDT + CASE LEN(DATEPART(hh, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(hh, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(hh, @DT)) END
	-- This gets the minutes for the provided datetime (2 char value)
	SELECT @DSTDT = @DSTDT + CASE LEN(DATEPART(mi, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(mi, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(mi, @DT)) END
	
	-- This query gets the timezone information from the TIME_ZONES table for the provided timezone
	SELECT
		@OFFSETHR=offset_hr,
		@OFFSETMI=offset_mi,
		@DSTOFFSETHR=dst_offset_hr,
		@DSTOFFSETMI=dst_offset_mi,
		@DSTEFFDT=dst_eff_dt,
		@DSTENDDT=dst_END_dt
	FROM time_zones
	WHERE timezone_cd = @TZ AND
		@DT BETWEEN eff_dt AND end_dt
	
	-- Checks to see if the DST parameter for the datetime provided is within the DST parameter for the timezone
	IF @DSTDT BETWEEN @DSTEFFDT AND @DSTENDDT
	BEGIN
		-- Increase the datetime by the hours and minutes assigned to the timezone
		SET @NEWDT = DATEADD(hh,ABS(@DSTOFFSETHR),@DT)
		SET @NEWDT = DATEADD(mi,ABS(@DSTOFFSETMI),@NEWDT)
	END
	-- If the DST parameter for the provided datetime is not within the defined
	-- DST eff and end dates for the timezone then use the standard time offset
	ELSE
	BEGIN
		-- Increase the datetime by the hours and minutes assigned to the timezone
		SET @NEWDT = DATEADD(hh,ABS(@OFFSETHR),@DT)
		SET @NEWDT = DATEADD(mi,ABS(@OFFSETMI),@NEWDT)
	END

	-- Return the new date that has been converted to UTC time
	RETURN @NEWDT
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
