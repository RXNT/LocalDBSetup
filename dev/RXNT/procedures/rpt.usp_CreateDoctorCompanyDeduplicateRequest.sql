SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to create deduplication dc request
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_CreateDoctorCompanyDeduplicateRequest]
(
	@CompanyId				BIGINT,
	@LoggedInUserId			BIGINT,
	@ErrorMessage			VARCHAR(1000) OUTPUT,
	@ErrorExists			BIT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @ProcessStatusTypeId AS BIGINT

	SET @ErrorExists = 0
	SET @ErrorMessage = ''

	IF EXISTS ( SELECT	1
				FROM	rpt.DoctorCompanyDeduplicateRequests DCDR WITH (NOLOCK)
						INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DCDR.ProcessStatusTypeId
				WHERE	PST.Code in ('PENDG', 'INPRG') AND DCDR.CompanyId = @CompanyId AND DCDR.Active = 1)
	BEGIN
		SET @ErrorExists = 1
		SET @ErrorMessage = 'In Progress/Pending Doctor Company Deduplication Request exists, so cannot create new deduplication request for the company.'
	END
	ELSE
	BEGIN
		SELECT	@ProcessStatusTypeId = SPS.ProcessStatusTypeId 
		FROM	rpt.ProcessStatusTypes SPS WITH (NOLOCK)
		WHERE	Code = 'PENDG'

		INSERT INTO rpt.DoctorCompanyDeduplicateRequests 
		(CompanyId, ProcessStatusTypeId, Active, CreatedBy, CreatedDate)
		VALUES (@CompanyId, @ProcessStatusTypeId, 1, @LoggedInUserId, GETDATE())
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
