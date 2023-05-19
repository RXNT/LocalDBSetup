SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[UTCConvert] 
(

    @p1 datetime
)
RETURNS datetime
AS
BEGIN
	DECLARE @UTCDate datetime
	DECLARE @LocalDate datetime
	DECLARE @TimeDiff int

	-- Figure out the time difference between UTC and Local time
	SET @UTCDate = GETUTCDATE()
	SET @LocalDate = GETDATE()
	SET @TimeDiff = DATEDIFF(hh, @UTCDate, @LocalDate)


	-- Convert UTC to local time
	DECLARE @DateYouWantToConvert datetime
	DECLARE @ConvertedLocalTime datetime

	SET @DateYouWantToConvert = @p1
	SET @ConvertedLocalTime = DATEADD(hh, @TimeDiff, @DateYouWantToConvert)

	-- Check Results
	RETURN @ConvertedLocalTime
End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
