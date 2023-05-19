SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 27.10.2017
-- Description: Search IMplantable Device
-- =============================================
CREATE PROCEDURE [enc].[usp_SavePatientImplantableDeviceFromPatientEncounter]
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
	@ManufacturedDate DATETIME,
	@ExpirationDate DATETIME
AS
BEGIN
	IF ISNULL(@PatientImplantableDeviceId,0) = 0
		BEGIN
			INSERT INTO [ehr].[PatientImplantableDevice] 
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
					CreatedBy
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
					@LoggedInUserId
				)
			END
		ELSE 
			BEGIN
				UPDATE  [ehr].[PatientImplantableDevice] 
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
				WHERE PatientImplantableDeviceId=@PatientImplantableDeviceId
				AND PatientId=@PatientId
					
			END 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
