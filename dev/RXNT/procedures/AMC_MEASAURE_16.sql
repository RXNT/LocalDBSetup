SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_16]
	-- Add the parameters for the stored procedure here
@drid BIGINT,
@dtstart DATETIME,
@dtend DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    SELECT COALESCE(COUNT(DISTINCT A.PA_ID), 0) NUMERATOR, COALESCE(COUNT(distinct B.pa_id),0) DENOMINATOR FROM REFERRAL_MAIN B LEFT OUTER JOIN PATIENT_MEASURE_COMPLIANCE A ON A.DR_ID = B.MAIN_DR_ID AND A.PA_ID = B.PA_ID AND A.REC_TYPE=1  AND A.REC_DATE BETWEEN @DTSTART AND @DTEND WHERE B.MAIN_DR_ID=@DRID AND B.REF_START_dATE BETWEEN @DTSTART AND @DTEND
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
