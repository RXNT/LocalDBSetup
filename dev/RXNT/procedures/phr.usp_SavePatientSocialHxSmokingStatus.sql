SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 31-Oct-2017
-- Description:	To Save Patient Social Hx Smoking Status
-- =============================================

CREATE PROCEDURE [phr].[usp_SavePatientSocialHxSmokingStatus]
	@PatientSmokingStatusDetailExtId BIGINT OUTPUT,
	@PatientId BIGINT,
	@DoctorId BIGINT,
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@SmokingStatusCode VARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	DECLARE @Pa_Flag_Id BIGINT;
	IF ISNULL(@PatientSmokingStatusDetailExtId,0) = 0
		BEGIN
			
			INSERT INTO ehr.PatientSmokingStatusDetailExternal
			(
				SmokingStatusCode,
				Pa_Flag_Id,
				DoctorCompanyId,
				PatientId,
				StartDate,
				EndDate,
				Active,
				CreatedDate,
				CreatedBy
				
			) 
			VALUES 
			(
				@SmokingStatusCode,
				0,
				@DoctorCompanyId,
				@PatientId,
				@StartDate,
				@EndDate,
				1,
				GETDATE(),
				@LoggedInUserId
			)
		END 
	
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
