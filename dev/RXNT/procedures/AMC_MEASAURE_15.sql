SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Rasheed  
-- Create date: 03/10/2014  
-- Description: Automatic Measure Calculation - Missing Patients  
-- =============================================  
CREATE PROCEDURE [dbo].[AMC_MEASAURE_15]  
 -- Add the parameters for the stored procedure here  
@drid BIGINT,  
@dtstart DATETIME,  
@dtend DATETIME  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
	SET NOCOUNT ON;  
    SELECT coalesce(SUM(CASE WHEN B.REC_TYPE = 4 THEN 1 ELSE 0 END),0) NUMERATOR, COUNT(DISTINCT A.PA_ID) DENOMINATOR  FROM PATIENT_EXTENDED_DETAILS A LEFT OUTER JOIN patient_measure_compliance B ON A.PA_ID = B.pa_id WHERE A.DR_ID = @DRID and a.pa_ref_date between @DTSTART and @DTEND  
    SET NOCOUNT OFF;  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
