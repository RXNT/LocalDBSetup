SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	13-JUNE-2016
Description			:	This procedure is used to save Patient New Allergies
Modified By         :   JahabarYusuff M
Modified Date       :   16-Dec-2023
Description         :   Save rxnorm, allergy and reaction snomed
=======================================================================================
*/
 CREATE   PROCEDURE [ehr].[usp_SavePatientAllergies]	
    @PatientAllergyId BIGINT OUTPUT,
	@PatientId			BIGINT,	
	@AllergyId		BIGINT,
	@AllergyType	INT,
	@DateAdded		DATETIME,
	@Comments		varchar(2000),
	@ReactionString	varchar(225),
	@Status			BIT,
	@SeverityId		INT = NULL,
	@RecordSource	varchar(225) = NULL,
	@RxNormCode	varchar(225) = NULL,
	@LastModifiedDate	DATETIME = NULL,
	@DateEnd	DATETIME = NULL,
	@ReactionSNOMED	varchar(15),
	@AllergySNOMED	varchar(15),
	@AllergyDescription varchar(225),
	@DoctorId	BIGINT,
	@SnomedTerm varchar(500)
	
AS
BEGIN
IF ISNULL(@PatientAllergyId,0) = 0
BEGIN
	INSERT INTO patient_new_allergies (
		pa_id, 
		allergy_id, 
		allergy_type, 
		add_date, 
		comments, 
		reaction_string, 
		severity_id,
		record_source,
		rxnorm_code,
		last_modified_date,
		disable_date,
		reaction_snomed,
		allergy_snomed, 
		allergy_description, 
		dr_id,
		snomed_term
	) 
	VALUES (
		@PatientId, 
		@AllergyId, 
		@AllergyType, 
		@DateAdded, 
		@Comments, 
		@ReactionString, 
		@SeverityId,
		@RecordSource,
		@RxNormCode,
		@LastModifiedDate,
		@DateEnd,
		@ReactionSNOMED,
		@AllergySNOMED,
		@AllergyDescription,
		@DoctorId,
		@SnomedTerm
	)
	SELECT @PatientAllergyId = SCOPE_IDENTITY() 
END
ELSE 
	 BEGIN
		UPDATE PATIENT_NEW_ALLERGIES SET 
			COMMENTS=@Comments, 
			record_source= @RecordSource,
			REACTION_STRING=@ReactionString, 
			severity_id = @SeverityId, 
			ADD_DATE=@DateAdded, 
			STATUS=@Status,
			last_modified_date=@LastModifiedDate,
			disable_date=@DateEnd,
			reaction_snomed=@ReactionSNOMED, 
			allergy_snomed=@AllergySNOMED, 
			allergy_description = @AllergyDescription, 
			dr_id=@DoctorId,
			snomed_term=@SnomedTerm
		WHERE PA_ALLERGY_ID = @PatientAllergyId
	 END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
