SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 03/22/2022
-- Description:	Get Patient and Request Id from message control id
-- =============================================
CREATE PROCEDURE [dbo].[usb_GetInfoFromImmunizationMCI]
	-- Add the parameters for the stored procedure here
	@MessageControlId VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1
	patient_id,
	request_id
	FROM [dbo].[tblPatientExternalVaccinationRequests] WITH(NOLOCK)
	WHERE message_control_id = @MessageControlId and requested_date > GETDATE() - 10 -- only look for data from the past 10 days
	ORDER BY request_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
