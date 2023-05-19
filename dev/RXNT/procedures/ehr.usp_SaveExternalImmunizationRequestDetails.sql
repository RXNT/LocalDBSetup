SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveExternalImmunizationRequestDetails]
	-- Add the parameters for the stored procedure here
	@MessageControlId VARCHAR(100),
	@RequestId INT,
	@OutgoingMessage VARCHAR(MAX) = NULL,
	@IncomingMessage VARCHAR(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS(SELECT TOP 1 * FROM [dbo].[tblPatientExternalVaccinationRequestDetails] WITH(NOLOCK)
		WHERE message_control_id = @MessageControlId)
		BEGIN
			INSERT INTO [dbo].[tblPatientExternalVaccinationRequestDetails]
			(
				message_control_id,
				request_id,
				outgoing_message,
				incoming_message
			)
			VALUES
			(
				@MessageControlId,
				@RequestId,
				@OutgoingMessage,
				@IncomingMessage
			)
		END
	ELSE 
		BEGIN
			UPDATE [dbo].[tblPatientExternalVaccinationRequestDetails]
			SET 
			outgoing_message = ISNULL(@OutgoingMessage, [outgoing_message]),
			incoming_message = ISNULL(@IncomingMessage, [incoming_message])
			WHERE message_control_id = @MessageControlId
		END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
