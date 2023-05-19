SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Samip Neupane>
-- Create date: <03/17/2022>
-- Description:	<Get the status of last external immunization request for patient>
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetStatusOfLatestPatientImmunizationRequest]
	-- Add the parameters for the stored procedure here
	@PatientId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TOP 1
		request_id,
		patient_id,
		requested_date,
		status,
		comments
	FROM [dbo].[tblPatientExternalVaccinationRequests] WITH(NOLOCK)
	WHERE
		patient_id = @PatientId
	ORDER BY request_id DESC
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
