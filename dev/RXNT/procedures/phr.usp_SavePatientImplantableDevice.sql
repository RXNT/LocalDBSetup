SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SavePatientImplantableDevice]
	@PatientId	BIGINT,
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@ImplantableDeviceId BIGINT,
	@PatientImplantableDeviceId BIGINT,
	@Active BIT,
	@CreatedOn DATETIME,
	@BatchNumber VARCHAR(200),
	@LotNumber VARCHAR(200),
	@SerialNumber VARCHAR(200),
	@Source VARCHAR(200),
	@ManufacturedDate DATETIME,
	@ExpirationDate DATETIME
AS
BEGIN
	IF ISNULL(@PatientImplantableDeviceId,0) = 0
		BEGIN
			INSERT INTO [ehr].[PatientImplantableDeviceExternal] 
				(
					ImplantableDeviceId,
					DoctorCompanyId,
					PatientId,
					BatchNumber,
					LotNumber,
					SerialNumber,
					ManufacturedDate,
					ExpirationDate,
					CreatedOn,
					Active,
					CreatedDate,
					CreatedBy,
					Source
				) 
			VALUES 
				(
					@ImplantableDeviceId,
					@DoctorCompanyId,
					@PatientId,
					@BatchNumber,
					@LotNumber,
					@SerialNumber,
					@ManufacturedDate,
					@ExpirationDate,
					@CreatedOn,
					@Active,
					GETDATE(),
					@LoggedInUserId,
					@Source
				)
			END
		ELSE 
			BEGIN
				UPDATE  [ehr].[PatientImplantableDeviceExternal] 
				SET
					ImplantableDeviceId=@ImplantableDeviceId,
					DoctorCompanyId=@DoctorCompanyId,
					PatientId=@PatientId,
					BatchNumber=@BatchNumber,
					LotNumber=@LotNumber,
					SerialNumber=@SerialNumber,
					ManufacturedDate=@ManufacturedDate,
					ExpirationDate=@ExpirationDate,
					CreatedOn=@CreatedOn,
					Active=@Active,
					ModifiedDate=GETDATE(),
					ModifiedBy=@LoggedInUserId
				WHERE PatientImplantableDeviceExtId=@PatientImplantableDeviceId
				AND PatientId=@PatientId
					
			END 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
