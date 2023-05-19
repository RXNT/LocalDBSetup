SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	20-OCT-2017
Description			:	This procedure is used to save Patient Past Hx Allergies
Modified By         :   JahabarYusuff M
Modified Date       :   05-Dec-2022
Description         :   save allergy and reaction snomed
=======================================================================================
*/
 CREATE   PROCEDURE [ehr].[usp_SavePatientPastHxAllergy]	
    @PatientPastHxAllergyId BIGINT OUTPUT,
	@PatientId			BIGINT,	
	@AllergyId		BIGINT,
	@AllergyType	INT,
	@DateAdded		DATETIME,
	@Comments		varchar(2000),
	@Reaction	varchar(225),
	@Source	varchar(225),
	@Active		BIT,
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@ReactionSNOMED	varchar(15) = NULL,
	@AllergySNOMED	varchar(15) = NULL,
	@AllergyDescription varchar(225),
	@RxNormCode	varchar(225) = NULL,
	@SnomedTerm varchar(500) = NULL
AS
BEGIN
	IF ISNULL(@PatientPastHxAllergyId,0) = 0
		BEGIN
			INSERT INTO ehr.PatientPastHxAllergies (
				PatientId, 
				AllergyId, 
				AllergyType, 
				CreatedOn, 
				Comments, 
				Reaction,
				RecordSource,
				Active,
				DoctorCompanyId,
				CreatedDate,
				CreatedBy,
				rxnorm_code,
				reaction_snomed,
				allergy_snomed, 
				AllergyDescription,
				snomed_term					
			) VALUES (
				@PatientId, 
				@AllergyId, 
				@AllergyType, 
				@DateAdded, 
				@Comments, 
				@Reaction,
				@Source,
				@Active,
				@DoctorCompanyId,
				GETDATE(),
				@LoggedInUserId,
				@RxNormCode,
				@ReactionSNOMED,
				@AllergySNOMED,
				@AllergyDescription,
				@SnomedTerm
			)
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
