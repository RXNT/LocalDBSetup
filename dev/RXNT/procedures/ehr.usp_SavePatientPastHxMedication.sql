SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	23-OCT-2017
Description			:	
Last Modified By	:	Samip Neupane
Last Modifed Date	:	12/02/2022
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SavePatientPastHxMedication]
    @PatientPastHxMedicationId BIGINT OUTPUT,
    @DrugId				BIGINT,
	@PatientId			BIGINT,
	@loggedInDoctorId	BIGINT,
	@MainDoctorId		BIGINT,
	@DoctorCompanyId	BIGINT,
	@DrugName			VARCHAR(200),
	@DateAdded			DATETIME,
	@Comments			VARCHAR(255),
	@Dosage				VARCHAR(255),
	@DurationAmount		VARCHAR(15),
	@DurationUnit		VARCHAR(80),
	@DetailComments		VARCHAR(255),
	@NoOfRefills		INT,
	@IsUseGeneric		BIT,
	@IsPrn				BIT,
	@PrnDescription		VARCHAR(50),
	@DaysSupply			INT,
	@StartDate			DATETIME,
	@EndDate			DATETIME,
	@OrderReason		VARCHAR(500),
	@Source				VARCHAR(255),
	@RxNormCode			VARCHAR(20)
	
AS
BEGIN

	IF ISNULL(@PatientPastHxMedicationId,0) = 0
	BEGIN

/*---- Delete Active Medication If Exist */
	IF @DrugId = -1
	BEGIN
		DELETE FROM PatientPastHxMedication WHERE PatientId= @PatientId and DrugName = @DrugName
	END
	ELSE
	BEGIN
		DELETE FROM PatientPastHxMedication WHERE PatientId= @PatientId and DrugId = @DrugId
		SET @DrugName = null;
	END
	
/*-----  Insert Past Hx Medication Med ---- */
   	INSERT INTO PatientPastHxMedication 
   		(
   			PatientId,
   			DrugId,
   			DrugName, 
   			CreatedBy, 
   			CreatedDate, 
   			Comments,
   			Reason,
   			RecordSource,
   			Dosage, 
   			DurationAmount,
   			DurationUnit, 
   			DrugComments, 
   			numb_refills,
   			UseGeneric, 
   			Prn, 
   			PrnDescription, 
   			DaysSupply, 
   			DateStart, 
   			DateEnd,
   			DoctorCompanyId,
   			Active,
			RxNormCode
   		) 
   	VALUES 
   		(
   			@PatientId, 
   			@DrugId, 
   			@DrugName, 
   			@loggedInDoctorId, 
   			@DateAdded, 
   			left(@Comments, 255),
   			left(@OrderReason, 500), 
   			@Source,
   			left(@Dosage, 255), 
   			@DurationAmount, 
   			@DurationUnit, 
   			left(@DetailComments,255), 
   			@NoOfRefills,
   			@IsUseGeneric, 
   			@IsPrn, 
   			left(@PrnDescription, 50), 
   			@DaysSupply, 
   			@StartDate, 
   			@EndDate,
   			@DoctorCompanyId,
   			1,
			@RxNormCode
   		)
   	SET @PatientPastHxMedicationId =  SCOPE_IDENTITY();
   	
	END
	ELSE
	BEGIN
		UPDATE PatientPastHxMedication
		SET 
			Dosage = @Dosage,
			DurationAmount = @DurationAmount,
			DurationUnit = @DurationUnit ,
			DrugComments = @DetailComments ,
			numb_refills = @NoOfRefills,
			UseGeneric = @IsUseGeneric,
			DaysSupply = @DaysSupply,
			Prn = @IsPrn, 
			PrnDescription = @PrnDescription, 
			DateStart = @StartDate, 
			DateEnd = @EndDate,
			Comments = @Comments,
			Reason = @OrderReason,
			ModifiedDate = GETDATE(),
			ModifiedBy = @loggedInDoctorId
		WHERE PatientPastHxMedicationId = @PatientPastHxMedicationId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
