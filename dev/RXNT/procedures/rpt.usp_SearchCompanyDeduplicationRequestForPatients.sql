SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to search deduplication dc request
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_SearchCompanyDeduplicationRequestForPatients]
(
	@CompanyId				BIGINT,
	@StartDate				DATETIME2,
	@EndDate				DATETIME2,
	@ProcessStatusTypeCode	VARCHAR(5)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT	SMDR.*, SPS.Code, SPS.Name, CMP.dc_Name As CompanyName
	FROM	rpt.DoctorCompanyDeduplicateRequests SMDR WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = SMDR.ProcessStatusTypeId
			INNER JOIN dbo.doc_companies CMP WITH (NOLOCK) on CMP.dc_id = SMDR.CompanyId
	WHERE	(SMDR.CompanyId = @CompanyId Or @CompanyId IS NULL)
			AND (SPS.Code = @ProcessStatusTypeCode OR @ProcessStatusTypeCode IS NULL)
			AND (DATEADD(D, 0, DATEDIFF(D, 0, SMDR.CreatedDate)) between @StartDate AND @EndDate
			OR (@StartDate IS NULL AND @EndDate IS NULL))
			AND SMDR.Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
