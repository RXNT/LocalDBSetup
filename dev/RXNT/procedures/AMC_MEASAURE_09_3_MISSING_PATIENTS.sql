SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_09_3_MISSING_PATIENTS] 
	-- Add the parameters for the stored procedure here
@encounteronly BIT,
@drid BIGINT,
@dtstart DATETIME,
@dtend DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients where pa_id in ( select distinct denominator from ( SELECT CASE WHEN  ISNULL(pad.pa_ht,0)>0 AND ISNULL(pad.pa_wt,0)>0 THEN pad.pa_id ELSE NULL END NUMERATOR ,   e.patient_id DENOMINATOR 
FROM enchanced_encounter e
INNER JOIN patients pat ON pat.pa_id=e.patient_id
LEFT OUTER JOIN patient_vitals pad ON e.patient_id=pad.pa_id --AND CONVERT(VARCHAR(30),e.enc_date,101)=CONVERT(VARCHAR(30),pad.record_date,101) --AND pad.age>3
WHERE e.dr_id = @DRID AND e.enc_date BETWEEN @DTSTART AND @DTEND 
AND (DATEDIFF(MONTH,pat.pa_dob,e.enc_date)>=12*2 OR( pad.pa_ht>0 AND  pad.pa_wt>0))) q where q.numerator is null) order by pa_first, pa_last
 
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
