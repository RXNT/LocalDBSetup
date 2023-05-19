SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	21-JUNE-2016
Description			:	This procedure is used to Save Patient med History
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SavePatientMedHx]
    @PatientMedHxId BIGINT OUTPUT,
    @DrugId				BIGINT,
	@PatientId			BIGINT,
	@loggedInDoctorId	BIGINT,
	@MainDoctorId		BIGINT,
	@DrugName			VARCHAR(200),
	@DateAdded			DATETIME,
	@Comments			VARCHAR(255),
	@OrderReason		VARCHAR(255),
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
	@EndDate			DATETIME
AS
BEGIN
	IF ISNULL(@PatientMedHxId,0) = 0
	BEGIN
		INSERT INTO patient_medications_hx 
		(pa_id, drug_id,drug_name, added_by_dr_id, date_added, comments,order_reason,dosage, duration_amount,duration_unit, 
		drug_comments, numb_refills, use_generic, prn, prn_description, days_supply, date_start, date_end, for_dr_id) 
		VALUES (@PatientId, @DrugId,@DrugName, @loggedInDoctorId, @DateAdded, left(@Comments, 255), @OrderReason, left(@Dosage, 255), @DurationAmount, @DurationUnit, 
		left(@DetailComments,255), @NoOfRefills, @IsUseGeneric, @IsPrn, left(@PrnDescription, 50), @DaysSupply, @StartDate, @EndDate, @MainDoctorId)
		SET @PatientMedHxId = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE patient_medications_hx 
		SET comments=left(@Comments, 255), order_reason = @OrderReason, dosage=left(@Dosage, 255), duration_amount=@DurationAmount,
		duration_unit=@DurationUnit, drug_comments=left(@DetailComments,255), numb_refills= @NoOfRefills, 
		use_generic=@IsUseGeneric, prn=@IsPrn, prn_description=left(@PrnDescription, 50), days_supply=@DaysSupply, 
		date_start = @StartDate , date_end=@EndDate WHERE pam_id=@PatientMedHxId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
