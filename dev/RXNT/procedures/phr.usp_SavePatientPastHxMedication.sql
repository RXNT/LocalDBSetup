SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	VINOD
Create date			:	18-Feb-2018
Description			:	
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_SavePatientPastHxMedication]
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
	@Source		VARCHAR(500)
AS
BEGIN

	IF ISNULL(@PatientPastHxMedicationId,0) = 0
	BEGIN

/*---- Delete Active Medication If Exist */
	IF @DrugId = -1
	BEGIN
		DELETE FROM ehr.PatientPastHxMedicationExternal WHERE PatientId= @PatientId and DrugName = @DrugName
	END
	ELSE
	BEGIN
		DELETE FROM ehr.PatientPastHxMedicationExternal WHERE PatientId= @PatientId and DrugId = @DrugId
		SET @DrugName = null;
	END
	
/*-----  Insert Past Hx Medication Med ---- */
   	INSERT INTO ehr.PatientPastHxMedicationExternal 
   		(
   			PatientId,
   			DrugId,
   			DrugName, 
   			CreatedBy, 
   			CreatedDate, 
   			Comments,
   			Reason,
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
   			RecordSource
   		) 
   	VALUES 
   		(
   			@PatientId, 
   			@DrugId, 
   			@DrugName, 
   			1, 
   			@DateAdded, 
   			left(@Comments, 255),
   			left(@OrderReason, 500), 
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
   			@Source
   		)
   	SET @PatientPastHxMedicationId =  SCOPE_IDENTITY();
   	
	END
	ELSE
	BEGIN
		UPDATE ehr.PatientPastHxMedicationExternal
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
		WHERE PatientPastHxMedicationExtId = @PatientPastHxMedicationId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
