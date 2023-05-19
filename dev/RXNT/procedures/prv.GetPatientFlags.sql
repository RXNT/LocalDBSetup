SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Balaji
-- Create date: 28-October-2016
-- Description:	Get Patient Flags
-- =============================================
CREATE PROCEDURE [prv].[GetPatientFlags]
	-- Add the parameters for the stored procedure here
	@PatientId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT PA_ID, FLAG_TITLE FROM PATIENT_FLAG_DETAILS A 
	INNER JOIN PATIENT_FLAGS B ON A.FLAG_ID = B.FLAG_ID WHERE A.PA_ID =@PatientId order by pa_id   
 
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
