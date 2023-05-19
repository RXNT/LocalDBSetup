SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	Save patient Hospitalization Hx
-- Modified By: JahabarYusuff M
-- Modified Date: 07-Nov-2022
-- Description:	Remove id9 column save
-- =============================================
CREATE   PROCEDURE [phr].[usp_SavePatientHospitalizationHx]
	@ID BIGINT OUTPUT,
	@PatientId BIGINT,
	@Problem VARCHAR(MAX),
	@ICD10 VARCHAR(MAX),
	@ICD10Description VARCHAR(MAX),
	@SNOMED VARCHAR(MAX),
	@SNOMEDDescription VARCHAR(MAX),
	@Source VARCHAR(MAX) = NULL,
	@CreatedOn DATETIME,
	@DocotorId BIGINT,
	@AddedByDrID BIGINT,
	@IsEnable BIT
AS
BEGIN
	IF ISNULL(@ID,0) = 0
	BEGIN
		INSERT INTO patient_hospitalization_hx_external (phe_pat_id,phe_problem,phe_dr_id,
		phe_added_by_dr_id,phe_created_on,last_modified_on,last_modified_by,phe_enable,
		 phe_icd10, phe_icd10_description, phe_snomed, phe_snomed_description,phe_source)
        VALUES (@PatientId,@problem,@DocotorId,@AddedByDrID,@CreatedOn,GETDATE(),@AddedByDrID,@IsEnable,
         @ICD10, @ICD10Description, @SNOMED, @SNOMEDDescription,@Source); 
        SET @ID =  SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE patient_hospitalization_hx_external 
		SET phe_pat_id=@PatientId,
		phe_problem=@problem,
		phe_icd10 = @ICD10,	
		phe_icd10_description = @ICD10Description,
		phe_snomed = @SNOMED,
		phe_snomed_description = @SNOMEDDescription,
		last_modified_on=GETDATE(),
		last_modified_by=@AddedByDrID,
		phe_enable=@IsEnable, 
		phe_created_on=@CreatedOn 
		WHERE phe_pat_id=@PatientId AND phe_hosphxid=@id;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
