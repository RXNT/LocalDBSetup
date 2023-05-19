SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to update Deduplication Reqeuest status
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_UpdateDoctorCompanyDeduplicateRequestStatus]
(
	@CompanyId							BIGINT,
	@DoctorCompanyDeduplicateRequestId	BIGINT,
	@ProcessStatusCode					VARCHAR(5),
	@ProcessMessage						VARCHAR(4000),
	@LoggedInUserId						BIGINT,
	@ErrorMessage						VARCHAR(1000) OUTPUT,
	@ErrorExists						BIT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;	
	
	DECLARE @ProcessStatusId AS BIGINT
	DECLARE @CreatedDate AS DATETIME
	DECLARE @CreatedBy AS BIGINT
	
	SET @ErrorExists = 0
	SET @ErrorMessage = ''
	SET @CreatedDate = GETDATE()

	IF ISNULL(@LoggedInUserId,0)<=0
	BEGIN
		SET @CreatedBy = 1
	END
	ELSE
	BEGIN
		SET @CreatedBy = @LoggedInUserId
	END

	IF @ProcessStatusCode = 'CANCL'
	BEGIN
		IF EXISTS ( SELECT	1
					FROM	rpt.DoctorCompanyDeduplicateRequests DCDR WITH (NOLOCK)
							INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DCDR.ProcessStatusTypeId
					WHERE	PST.Code = 'INPRG' AND DCDR.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId AND DCDR.Active = 1)
		BEGIN
			SET @ErrorExists = 1
			SET @ErrorMessage = 'Doctor Company Deduplication Request is In Progress, so cannot cancel the request.'
		END
	END
	
	IF @ErrorExists = 0
	BEGIN
		SELECT	@ProcessStatusId = ProcessStatusTypeId
		FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
		WHERE	PST.Code = @ProcessStatusCode

		UPDATE	rpt.DoctorCompanyDeduplicateRequests
		SET		ProcessStatusTypeId = @ProcessStatusId,
				ProcessStartDate = CASE WHEN @ProcessStatusCode = 'INPRG' THEN GETDATE() ELSE ProcessStartDate END,
				ProcessEndDate = CASE WHEN @ProcessStatusCode != 'INPRG' THEN GETDATE() ELSE ProcessEndDate END,
				ProcessStatusMessage = @ProcessMessage,
				ModifiedBy = @CreatedBy,
				ModifiedDate = @CreatedDate
		WHERE	DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
