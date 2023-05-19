SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Author:		Niyaz
-- Create date: 1-Feb-2018
-- Description:	To get pending cqm measure requests by year
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_GetCQMMeasureRequests]  
AS
BEGIN
	SELECT TOP 100 RequestId, DoctorId, StartDate, EndDate, StatusId, CreatedOn, CreatedBy, DataImportStatus,RetryCount
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK)
	WHERE (StatusId = 1 OR (StatusId = 3 AND ISNULL(RetryCount,0) <= 3)) AND Active = 1 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
