SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_11_MISSING_PATIENTS] 
	-- Add the parameters for the stored procedure here
@drid BIGINT,
@dtstart DATETIME,
@dtend DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

     
	SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from 
	patients P with(nolock) 
	inner join 
	(
		SELECT DISTINCT A.pat_id AS DENOM
		FROM lab_main a with(nolock)
		INNER JOIN lab_order_info b with(nolock) ON a.lab_id = b.lab_id 
		INNER JOIN lab_result_info LRI with(nolock) on b.lab_report_id = LRI.lab_order_id
		WHERE DR_ID=@DRID and a.message_date between @DTSTART and @DTEND
	)
	DENOMINATOR on P.pa_id=DENOMINATOR.DENOM
	LEFT OUTER JOIN
	( 	
		SELECT DISTINCT A.pat_id AS NUM
		FROM lab_main a with(nolock)
		INNER JOIN lab_order_info b with(nolock) ON a.lab_id = b.lab_id 
		INNER JOIN lab_result_info LRI with(nolock) on b.lab_report_id = LRI.lab_order_id
		WHERE DR_ID=@DRID and a.message_date between @DTSTART and @DTEND
	) NUMERATOR on P.pa_id=NUMERATOR.NUM
	where NUMERATOR.NUM is NULL
	order by pa_first, pa_last
	
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
