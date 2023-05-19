SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Samip Neupane>
-- Create date: <03/18/2022>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpsertPatientExternalImmunizationRequest]
	-- Add the parameters for the stored procedure here
	@RequestId INT = 0 OUTPUT,
	@PatientId BIGINT = 0, -- defaulting these to 0 for the update script
	@DoctorId BIGINT = 0,
	@MessageControlId VARCHAR(100),
	@RequestFilePath VARCHAR(1000) = NULL,
	@ResponseFilePath VARCHAR(1000) = NULL,
	@RequestedDate DATETIME = NULL,
	@ResponseReceivedDate DATETIME = NULL,
	@Status VARCHAR(100),
	@Comments VARCHAR(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>

	IF NOT EXISTS(SELECT * FROM [dbo].[tblPatientExternalVaccinationRequests] WITH(NOLOCK) WHERE message_control_id = @MessageControlId)
	BEGIN
		INSERT INTO [dbo].[tblPatientExternalVaccinationRequests](
			patient_id,
			dr_id,
			message_control_id,
			request_file_path,
			response_file_path,
			requested_date,
			response_received_date,
			status,
			comments
			)
		VALUES
		(
			@PatientId,
			@DoctorId,
			@MessageControlId,
			@RequestFilePath,
			@ResponseFilePath,
			@RequestedDate,
			@ResponseReceivedDate,
			@Status,
			@Comments
		)
		SET @RequestId=SCOPE_IDENTITY()
	END 
	ELSE
	BEGIN
		SELECT TOP 1 @RequestId= request_id
		FROM  [dbo].[tblPatientExternalVaccinationRequests] WITH(NOLOCK)
		WHERE message_control_id = @MessageControlId and requested_date > GETDATE() - 10
		ORDER BY request_id DESC

		UPDATE [dbo].[tblPatientExternalVaccinationRequests]
		SET 
			response_file_path = ISNULL(@ResponseFilePath, [response_file_path]),
			response_received_date = ISNULL(@ResponseReceivedDate, [response_received_date]),
			status = ISNULL(@Status, [status]),
			comments = ISNULL(@Comments, [comments])
		WHERE request_id = @RequestId
	END
	SELECT @RequestId RequestId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
