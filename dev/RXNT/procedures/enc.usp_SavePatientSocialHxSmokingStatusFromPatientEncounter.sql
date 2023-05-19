SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 31-Oct-2017
-- Description:	To Save Patient Social Hx Smoking Status
-- =============================================

CREATE PROCEDURE [enc].[usp_SavePatientSocialHxSmokingStatusFromPatientEncounter]
	@PatientFlagDetailId BIGINT OUTPUT,
	@PatientId BIGINT,
	@DoctorId BIGINT,
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@SmokingStatusCode VARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	IF @SmokingStatusCode IS NOT NULL AND LEN(@SmokingStatusCode) > 0
	BEGIN
	DECLARE @Pa_Flag_Id BIGINT;
	IF ISNULL(@PatientFlagDetailId,0) = 0
		BEGIN
		SELECT TOP 1 @Pa_Flag_Id=Pa_Flag_Id FROM dbo.patient_flag_details WHERE pa_id = @PatientId AND flag_id = @SmokingStatusCode
			
			IF @Pa_Flag_Id IS NULL
			BEGIN
				INSERT INTO dbo.patient_flag_details
				(
					pa_id,
					flag_id,
					date_added,
					dr_id
				) 
				VALUES 
				(
					@PatientId,
					@SmokingStatusCode,
					GETDATE(),
					@DoctorId
				)
				SET @Pa_Flag_Id = SCOPE_IDENTITY()
			END
			INSERT INTO ehr.PatientSmokingStatusDetail
			(
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
				@Pa_Flag_Id,
				@DoctorCompanyId,
				@PatientId,
				@StartDate,
				@EndDate,
				1,
				GETDATE(),
				@LoggedInUserId
			)
		END 
	ELSE 
		BEGIN
			UPDATE dbo.patient_flag_details
			SET
				flag_id = @SmokingStatusCode
			WHERE pa_id=@PatientId  AND pa_flag_id=@PatientFlagDetailId
			
			IF EXISTS (
				SELECT 1 FROM ehr.PatientSmokingStatusDetail WHERE PatientId=@PatientId AND Pa_Flag_Id=@PatientFlagDetailId
			) 
				BEGIN
					UPDATE ehr.PatientSmokingStatusDetail
					SET 
						StartDate=@StartDate,
						EndDate=@EndDate,
						ModifiedBy=@LoggedInUserId,
						ModifiedDate=GETDATE()
					WHERE PatientId=@PatientId AND Pa_Flag_Id=@PatientFlagDetailId
				END 
			ELSE 
				BEGIN
					INSERT INTO ehr.PatientSmokingStatusDetail
					(
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
						@PatientFlagDetailId,
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
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
