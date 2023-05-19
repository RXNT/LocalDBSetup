SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_08]
	-- Add the parameters for the stored procedure here
@drid BIGINT,
@dtstart DATETIME,
@dtend DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    select coalesce(SUM(case when p.pres_delivery_method > 1 then 1 else 0 end),0) numerator,  COUNT(p.pres_id) denominator from prescriptions p  with(nolock) inner join prescription_details pd with(nolock) on p.pres_id = pd.pres_id inner join RMIID1 r with(nolock) on pd.ddid = r.MEDID where pres_entry_date between @DTSTART and @DTEND and pres_void = 0 and not(pres_approved_date is null) and p.dr_id = @DRID and r.MED_REF_DEA_CD < 2
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
