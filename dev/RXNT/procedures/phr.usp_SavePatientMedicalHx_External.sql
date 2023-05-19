SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	Save patient Medical Hx External
-- Modified By: JahabarYusuff M
-- Modified Date: 07-Nov-2022
-- Description:	Remove id9 column save
-- =============================================
CREATE   PROCEDURE [phr].[usp_SavePatientMedicalHx_External]
	@ID BIGINT OUTPUT,
	@PatientId BIGINT,
	@Problem VARCHAR(MAX),
	@ICD10 VARCHAR(MAX),
	@ICD10Description VARCHAR(MAX),
	@SNOMED VARCHAR(MAX),
	@SNOMEDDescription VARCHAR(MAX),
	@Source VARCHAR(MAX),
	@CreatedOn DATETIME,
	@DocotorId BIGINT,
	@AddedByDrID BIGINT,
	@IsEnable BIT
AS
BEGIN
	IF ISNULL(@ID,0) = 0
	BEGIN
		INSERT INTO patient_medical_hx_external (pme_pat_id,pme_problem,pme_dr_id,
		pme_added_by_dr_id,pme_created_on,last_modified_date,pme_enable,pme_source,
		  pme_icd10, pme_icd10_description, pme_snomed, pme_snomed_description)
        VALUES (@PatientId,@problem,@DocotorId,@AddedByDrID,@CreatedOn,GETDATE(),@IsEnable,
        @Source, @ICD10, @ICD10Description, @SNOMED, @SNOMEDDescription); 
        SET @ID =  SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE patient_medical_hx_external 
		SET pme_pat_id=@PatientId,
		pme_problem=@problem,
		pme_icd10 = @ICD10,	
		pme_icd10_description = @ICD10Description,
		pme_snomed = @SNOMED,
		pme_snomed_description = @SNOMEDDescription,
		last_modified_date=GETDATE(),
		pme_enable=@IsEnable, 
		pme_created_on=@CreatedOn 
		WHERE pme_pat_id=@PatientId AND pme_medhxid=@id;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
