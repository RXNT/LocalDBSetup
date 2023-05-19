SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_08_MISSING_PATIENTS] 
	-- Add the parameters for the stored procedure here
@drid BIGINT,
@dtstart DATETIME,
@dtend DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients where pa_id in ( select distinct denominator from ( select case when p.pres_delivery_method > 1 then 1 else  null end numerator,  p.pa_id denominator from prescriptions p  with(nolock) inner join prescription_details pd with(nolock) on p.pres_id = pd.pres_id inner join RMIID1 r with(nolock) on pd.ddid = r.MEDID where pres_entry_date between @DTSTART and @DTEND and pres_void = 0 and p.dr_id = @DRID and not(pres_approved_date is null) and r.MED_REF_DEA_CD < 2) q where q.numerator is null) order by pa_first, pa_last
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
