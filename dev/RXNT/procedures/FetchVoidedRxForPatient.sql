SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchVoidedRxForPatient]
	@patId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM vwPatientVoidedHistory  WHERE pa_id = @patId order by pres_approved_date desc	
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
