SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	20-OCT-2017
Description			:	This procedure is used to save Patient Past Hx Allergies
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE   PROCEDURE [enc].[usp_SavePatientPastHxAllergyFromPatientEncounter]	
    @PatientPastHxAllergyId BIGINT OUTPUT,
	@PatientId			BIGINT,	
	@AllergyId		BIGINT,
	@AllergyType	INT,
	@DateAdded		DATETIME,
	@Comments		varchar(2000),
	@Reaction	varchar(225),
	@Active		BIT,
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@ReactionSnomed VARCHAR(15),
	@RxNorm VARCHAR(15),
	@Snomed VARCHAR(15),
	@AllergyDescription VARCHAR(500),
	@SnomedTerm VARCHAR(500)
AS
BEGIN
	IF ISNULL(@PatientPastHxAllergyId,0) = 0
		BEGIN
			INSERT INTO ehr.PatientPastHxAllergies 
				(PatientId, AllergyId, AllergyType, CreatedOn, Comments, Reaction,Active,DoctorCompanyId,CreatedDate,CreatedBy,
				rxnorm_code, reaction_snomed, allergy_snomed, AllergyDescription, snomed_term) 
			VALUES 
				(@PatientId, @AllergyId, @AllergyType, @DateAdded, @Comments, @Reaction,@Active,@DoctorCompanyId,GETDATE(),@LoggedInUserId,
				@RxNorm, @ReactionSnomed, @Snomed, @AllergyDescription, @SnomedTerm)
			 SET @PatientPastHxAllergyId = SCOPE_IDENTITY() 
		END
	ELSE 
		 BEGIN
			UPDATE ehr.PatientPastHxAllergies  SET 
				Comments=@Comments,
				Reaction=@Reaction, 
				CreatedOn=@DateAdded, 
				Active=@Active,
				ModifiedDate=GETDATE(),
				ModifiedBy=@LoggedInUserId,
				rxnorm_code=@RxNorm, 
				reaction_snomed=@ReactionSnomed, 
				allergy_snomed=@Snomed,
				AllergyDescription=@AllergyDescription,
				snomed_term = @SnomedTerm
			WHERE PatientPastHxAllergyId = @PatientPastHxAllergyId
		 END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
