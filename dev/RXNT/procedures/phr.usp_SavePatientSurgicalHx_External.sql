SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	Save patient Surgical Hx External
-- Modified By: JahabarYusuff M
-- Modified Date: 07-Nov-2022
-- Description:	Remove id9 column save
-- =============================================
CREATE   PROCEDURE [phr].[usp_SavePatientSurgicalHx_External]
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
		INSERT INTO patient_surgery_hx_external (pse_pat_id,pse_problem,pse_dr_id,
		pse_added_by_dr_id,pse_created_on,last_modified_on,pse_enable,
		 pse_icd10, pse_icd10_description, pse_snomed, pse_snomed_description,pse_source)
        VALUES (@PatientId,@problem,@DocotorId,@AddedByDrID,@CreatedOn,GETDATE(),@IsEnable,
          @ICD10, @ICD10Description, @SNOMED, @SNOMEDDescription,@Source); 
        SET @ID =  SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE patient_surgery_hx_external 
		SET pse_pat_id=@PatientId,
		pse_problem=@problem,
		pse_icd10 = @ICD10,	
		pse_icd10_description = @ICD10Description,
		pse_snomed = @SNOMED,
		pse_snomed_description = @SNOMEDDescription,
		last_modified_on=GETDATE(),
		pse_enable=@IsEnable, 
		pse_created_on=@CreatedOn 
		WHERE pse_pat_id=@PatientId AND pse_surghxid=@id;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
