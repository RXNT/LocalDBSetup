SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 29-DEC-2022
-- Description:	To get the Doctor cqm2022 request status 
-- =============================================

CREATE   PROCEDURE [cqm2022].[GetDoctorCQMRequestStatus]  
	@DoctorId BIGINT,
	@RequestStatus BIT OUTPUT,
	@RequestStatusId INT OUTPUT,
	@StartDate DATE,
	@EndDate DATE
AS
BEGIN
	IF EXISTS(SELECT 1  FROM cqm2022.DoctorCQMCalculationRequest WHERE  DoctorId=@DoctorId AND Active =1	
		AND StartDate=@StartDate
		AND EndDate=@EndDate)
	BEGIN
		SELECT TOP 1 @RequestStatusId= StatusId FROM cqm2022.DoctorCQMCalculationRequest WITH(NOLOCK) WHERE DoctorId=@DoctorId AND Active =1
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
