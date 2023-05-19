SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	VINOD
Create date			:	15-Feb-2018
Description			:	This procedure is used to save Patient Past Hx Allergies External
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/


CREATE PROCEDURE [phr].[usp_SavePatientPastHxAllergyExternal]	
    @PatientPastHxAllergyExtId BIGINT OUTPUT,
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
	@RxNormCode	varchar(15) = NULL
AS
BEGIN
	IF ISNULL(@PatientPastHxAllergyExtId,0) = 0
		BEGIN
			INSERT INTO ehr.PatientPastHxAllergiesExternal 
				(PatientId, AllergyId, AllergyType, CreatedOn, Comments, Reaction,RecordSource,Active,DoctorCompanyId,CreatedDate,CreatedBy,
				rxnorm_code,reaction_snomed,allergy_snomed, AllergyDescription) VALUES 
				(@PatientId, @AllergyId, @AllergyType, @DateAdded, @Comments, @Reaction,@Source,@Active,@DoctorCompanyId,GETDATE(),@LoggedInUserId,
					@RxNormCode,@ReactionSNOMED,@AllergySNOMED,@AllergyDescription)
			 SET @PatientPastHxAllergyExtId = SCOPE_IDENTITY() 
		END
	ELSE 
		 BEGIN
			UPDATE ehr.PatientPastHxAllergiesExternal  SET 
				Comments=@Comments,
				Reaction=@Reaction, 
				CreatedOn=@DateAdded, 
				Active=@Active,
				ModifiedDate=GETDATE(),
				ModifiedBy=@LoggedInUserId
			WHERE PatientPastHxAllergyExtId = @PatientPastHxAllergyExtId
		 END
END


  



 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
