SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_04]
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

    IF @encounteronly=1
	BEGIN
		SELECT SUM(CASE WHEN LEN(PA_ADDRESS1) > 1 AND LEN(PA_ZIP) > 1 AND pa_race_type IS NOT NULL AND pref_lang IS NOT NULL THEN 1 ELSE 0 END) NUMERATOR, COUNT(PA_ID) DENOMINATOR FROM PATIENTS with(nolock)  WHERE PA_ID IN (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1)
	END
	ELSE
	BEGIN
		SELECT SUM(CASE WHEN LEN(PA_ADDRESS1) > 1 AND LEN(PA_ZIP) > 1 AND pa_race_type IS NOT NULL AND pa_ethn_type IS NOT NULL AND pref_lang IS NOT NULL THEN 1 ELSE 0 END) NUMERATOR, COUNT(PA_ID) DENOMINATOR FROM PATIENTS with(nolock)  WHERE PA_ID IN (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) WHERE pres_approved_date between @DTSTART and @DTEND AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 and DR_ID=@DRID UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1)
	END
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
