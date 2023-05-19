SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	22-OCT-2017
Description			:	This procedure is used to save Patient New Allergies
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_AddHxToPatientAllergies]	
    @PatientAllergyId BIGINT OUTPUT,
	@PatientId	    BIGINT,	
	@AllergyId		BIGINT,
	@AllergyType	INT,
	@DateAdded		DATETIME,
	@Comments		varchar(2000),
	@ReactionString	varchar(225),
	@Status			BIT,
	@ReactionSNOMED	varchar(15) = NULL,
	@AllergySNOMED	varchar(15) = NULL,
	@AllergyDescription varchar(225),
	@RxNormCode	varchar(225) = NULL
AS
BEGIN
	IF NOT EXISTS(SELECT  1  FROM patient_new_allergies WITH(NOLOCK)
			WHERE allergy_id = @AllergyId
			AND allergy_type = @AllergyType AND pa_id=@PatientId)
	BEGIN
		INSERT INTO patient_new_allergies (pa_id, allergy_id, allergy_type, add_date, comments, reaction_string,
		rxnorm_code,reaction_snomed,allergy_snomed, allergy_description) VALUES 
		(@PatientId, @AllergyId, @AllergyType, @DateAdded, @Comments, @ReactionString,
		@RxNormCode,@ReactionSNOMED,@AllergySNOMED,@AllergyDescription)
		 SET @PatientAllergyId = SCOPE_IDENTITY() 
	 END
END

 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
