SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[AddQualityMeasureReports]
@DRID BIGINT,
@STARTDATE DATETIME,
@ENDDATE DATETIME,
@CQMTEXT VARCHAR(MAX),
@VERSION VARCHAR(5)
AS
BEGIN
	  Declare @year INT
      set @year= DATEPART(yyyy,@STARTDATE) 
      
      IF @year=YEAR(GETDATE())
      BEGIN
	 IF EXISTS(select dr_id from CQM_Measure_Reports where dr_id=@DRID and start_date=@STARTDATE and end_date=@ENDDATE and report_version=@VERSION)
      BEGIN
             update [CQM_Measure_Reports] set cqm_text=@cqmText,executed_date=GETDATE() where dr_id=@DRID and start_date=@STARTDATE 
             and end_date=@ENDDATE and report_version=@VERSION
      END   
      ELSE
      BEGIN
             INSERT INTO [CQM_Measure_Reports]([dr_id],[start_date],[end_date],[cqm_text],[executed_date],[report_version])
             VALUES(@DRID, @STARTDATE, @ENDDATE, @CQMTEXT,GETDATE(),@VERSION)
      END 
      END
      
      ELSE
      BEGIN
            INSERT INTO [CQM_Measure_Reports]([dr_id],[start_date],[end_date],[cqm_text],[executed_date],[report_version])
            VALUES(@DRID, @STARTDATE, @ENDDATE, @CQMTEXT,GETDATE(),@VERSION)
      END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
