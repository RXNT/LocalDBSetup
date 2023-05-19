SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec Check_DST
CREATE PROCEDURE UpdateArizoneOnDST
AS
BEGIN

DECLARE
    @year INT = YEAR(GETDATE()),
    @StartOfMarch DATETIME ,
    @StartOfNovember DATETIME ,
    @DstStart DATETIME ,
    @DstEnd DATETIME,
    @currentdate DATETIME


SET @currentdate = GETDATE()
SET @StartOfMarch = DATEADD(MONTH, 2, DATEADD(YEAR, @year - 1900, 0))
SET @StartOfNovember = DATEADD(MONTH, 10, DATEADD(YEAR, @year - 1900, 0));
SET @DstStart = DATEADD(HOUR, 2,
                        DATEADD(day,
                                ( ( 15 - DATEPART(dw, @StartOfMarch) ) % 7 )
                                + 7, @StartOfMarch))
SET @DstEnd = DATEADD(HOUR, 2,
                      DATEADD(day,
                              ( ( 8 - DATEPART(dw, @StartOfNovember) ) % 7 ),
                              @StartOfNovember))

IF(@currentdate >= @DstStart and @currentdate <= @DstEnd)
BEGIN
     update doctors set time_difference=3 where timezone='AZT'
END
ELSE
BEGIN
     update doctors set time_difference=2 where timezone='AZT'
END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
