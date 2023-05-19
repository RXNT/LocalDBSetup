SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to pending deduplication dc request
Last Modified By	:	JahabarYusuff (to get the Page Date)
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_CheckPendingDoctorCompanyDeduplicateRequest]
(
	@CompanyId				BIGINT,
	@LoggedInUserId			BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT	DCDR.*, PST.Code As ProcessStatusTypeCode, PST.Name As ProcessStatusTypeName, GETDATE() as PageDate 
	FROM	rpt.DoctorCompanyDeduplicateRequests DCDR WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DCDR.ProcessStatusTypeId
	WHERE	PST.Code in ('INPRG', 'PENDG') 
			AND DCDR.CompanyId = @CompanyId 
			AND DCDR.Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
