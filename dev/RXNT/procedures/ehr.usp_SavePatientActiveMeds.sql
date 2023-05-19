SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	10-JUNE-2016
Description			:	This procedure is used to Save Patient Active Meds
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SavePatientActiveMeds]
    @ActiveMedicationId BIGINT OUTPUT,
    @DrugId				BIGINT,
	@PatientId			BIGINT,
	@loggedInDoctorId	BIGINT,
	@MainDoctorId		BIGINT,
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
	@RecordSource		VARCHAR(500) ,
	@RxNormCode			VARCHAR(100) = NULL,
	@LastModifiedDate	DATETIME = NULL
AS
BEGIN

	IF ISNULL(@ActiveMedicationId,0) = 0
	BEGIN

/*---- Delete Active Medication If Exist */
	IF @DrugId = -1
	BEGIN
		DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID= @PatientId and drug_name = @DrugName
	END
	ELSE
	BEGIN
		DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID= @PatientId and drug_id = @DrugId
		--SET @DrugName = null;
	END
	
/*-----  Insert Active Med ---- */
   	INSERT INTO patient_active_meds 
   	(pa_id, drug_id,drug_name, added_by_dr_id, date_added, comments,order_reason,dosage, duration_amount,duration_unit, drug_comments, 
   	numb_refills, use_generic, prn, prn_description, days_supply, date_start, date_end, for_dr_id,record_source,rxnorm_code,last_modified_date) 
   	VALUES (@PatientId, @DrugId, @DrugName, @loggedInDoctorId, @DateAdded, left(@Comments, 255),left(@OrderReason, 500), left(@Dosage, 255), @DurationAmount, @DurationUnit, left(@DetailComments,255),
   	 @NoOfRefills, @IsUseGeneric, @IsPrn, left(@PrnDescription, 50), @DaysSupply, @StartDate, @EndDate, @MainDoctorId,@RecordSource,@RxNormCode,@LastModifiedDate)
   	 
   	SET @ActiveMedicationId =  SCOPE_IDENTITY();
   	
	END
	ELSE
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
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
