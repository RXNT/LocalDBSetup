SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	26-APR-2018
Description			:	This procedure is used to Save Patient Active Meds
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [hospice].[SavePatientActiveMeds]
    @ActiveMedicationId BIGINT OUTPUT,
    @DrugId				BIGINT,
	@PatientId			BIGINT,
	@LoggedInDoctorId	BIGINT,
	@MainDoctorId		BIGINT,
	@DrugName			VARCHAR(200),
	@DateAdded			DATETIME=NULL,
	@Comments			VARCHAR(255)=NULL,
	@Dosage				VARCHAR(255),
	@DurationAmount		VARCHAR(15)=NULL,
	@DurationUnit		VARCHAR(80)=NULL,
	@DetailComments		VARCHAR(255)=NULL,
	@NoOfRefills		INT,
	@IsUseGeneric		BIT,
	@IsPrn				BIT=0,
	@PrnDescription		VARCHAR(50)=NULL,
	@DaysSupply			INT,
	@StartDate			DATETIME,
	@EndDate			DATETIME,
	@OrderReason		VARCHAR(500)=NULL,
	@RecordSource		VARCHAR(500)=NULL,
	@RxNormCode			VARCHAR(100) = NULL,
	@LastModifiedDate	DATETIME = NULL,
	@ActionCode			VARCHAR(1)=NULL
AS
BEGIN

	SELECT TOP 1 @ActiveMedicationId=ISNULL(pam_id,0) FROM patient_active_meds WITH(NOLOCK) WHERE drug_id=@DrugId AND pa_id=@PatientId AND drug_name=@DrugName
	
	IF @EndDate IS NOT NULL AND @EndDate < GETDATE() AND ISNULL(@ActiveMedicationId,0)>0
	BEGIN
		DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID= @PatientId and pam_id=@ActiveMedicationId
		SET @ActiveMedicationId = 0
	END
	ELSE IF @ActionCode = 'A' AND ISNULL(@ActiveMedicationId,0)=0
	BEGIN

/*---- Delete Active Medication If Exist */
	IF @DrugId = -1
	BEGIN
		DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID= @PatientId and drug_name = @DrugName
		SET @ActiveMedicationId = 0
	END
	ELSE
	BEGIN
		DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID= @PatientId and drug_id = @DrugId
		SET @ActiveMedicationId = 0
		--SET @DrugName = null;
	END
	
/*-----  Insert Active Med ---- */
   	INSERT INTO patient_active_meds 
   	(pa_id, drug_id,drug_name, added_by_dr_id, date_added, comments,order_reason,dosage, duration_amount,duration_unit, drug_comments, 
   	numb_refills, use_generic, prn, prn_description, days_supply, date_start, date_end, for_dr_id,record_source,rxnorm_code,last_modified_date) 
   	VALUES (@PatientId, @DrugId, @DrugName, @loggedInDoctorId, ISNULL(@DateAdded,GETDATE()), left(@Comments, 255),left(@OrderReason, 500), left(@Dosage, 255), @DurationAmount, @DurationUnit, left(@DetailComments,255),
   	 @NoOfRefills, @IsUseGeneric, @IsPrn, left(@PrnDescription, 50), @DaysSupply, @StartDate, @EndDate, @MainDoctorId,@RecordSource,@RxNormCode,@LastModifiedDate)
   	 
   	SET @ActiveMedicationId = SCOPE_IDENTITY();
   	
	END
	ELSE IF @ActionCode = 'U' AND ISNULL(@ActiveMedicationId,0)>0
	BEGIN
		UPDATE [dbo].[patient_active_meds] 
		SET [dosage] = @Dosage,
		[duration_amount] = @DurationAmount,
		[duration_unit] = @DurationUnit ,
		[drug_comments] = @DetailComments ,
		[numb_refills] = @NoOfRefills ,
		[use_generic] = @IsUseGeneric,
		[days_supply] = @DaysSupply,
		[prn] = @IsPrn, 
		[prn_description] = @PrnDescription, 
		[date_start] = @StartDate, 
		[date_end] = @EndDate,
		[comments] = @Comments,
		[order_reason] = @OrderReason,
		[record_source] = @RecordSource,
		[last_modified_date] = GETDATE(),
		[last_modified_by] = @loggedInDoctorId
		WHERE pam_id = @ActiveMedicationId
	END
	ELSE IF @ActionCode = 'D' AND ISNULL(@ActiveMedicationId,0)>0
	BEGIN
		DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID= @PatientId and pam_id=@ActiveMedicationId
		SET @ActiveMedicationId = 0
	END
	ELSE IF @ActionCode = 'D' AND ISNULL(@ActiveMedicationId,0)=0
	BEGIN
		IF @DrugId = -1
		BEGIN
			DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID= @PatientId and drug_name = @DrugName
			SET @ActiveMedicationId = 0
		END
		ELSE
		BEGIN
			DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID= @PatientId and drug_id = @DrugId
			SET @ActiveMedicationId = 0
			--SET @DrugName = null;
		END
	END
	SELECT ISNULL(@ActiveMedicationId,0)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
