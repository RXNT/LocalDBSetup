SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 24-OCT-2018
-- Description:	To get the Doctor cqm2019 request status 
-- =============================================

CREATE PROCEDURE [cqm2019].[GetDoctorCQMRequestStatus]  
	@DoctorId BIGINT,
	@RequestStatus BIT OUTPUT,
	@RequestStatusId INT OUTPUT,
	@StartDate DATE,
	@EndDate DATE
AS
BEGIN
	IF EXISTS(SELECT 1  FROM cqm2019.DoctorCQMCalculationRequest WHERE  DoctorId=@DoctorId AND Active =1	
		AND StartDate=@StartDate
		AND EndDate=@EndDate)
	BEGIN
		SELECT TOP 1 @RequestStatusId= StatusId FROM cqm2019.DoctorCQMCalculationRequest WITH(NOLOCK) WHERE DoctorId=@DoctorId AND Active =1
		AND StartDate=@StartDate
		AND EndDate=@EndDate
		ORDER BY CreatedOn DESC
		SET @RequestStatus=1
	END
	ELSE
	BEGIN
		SET @RequestStatus=0
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
