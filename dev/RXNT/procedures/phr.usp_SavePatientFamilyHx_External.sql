SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 22-Feb-2018
-- Description:	Save patient Family Hx
-- Modified By: JahabarYusuff M
-- Modified Date: 07-Nov-2022
-- Description:	Remove id9 column save
-- =============================================
CREATE   PROCEDURE [phr].[usp_SavePatientFamilyHx_External]
	@ID BIGINT OUTPUT,
	@PatientId BIGINT,
	@MemeberRelationId BIGINT,
	@Problem VARCHAR(MAX),
	@ICD10 VARCHAR(MAX),
	@ICD10Description VARCHAR(MAX),
	@SNOMED VARCHAR(MAX),
	@SNOMEDDescription VARCHAR(MAX),
	@CreatedOn DATETIME,
	@DocotorId BIGINT,
	@AddedByDrID BIGINT,
	@IsEnable BIT
AS
BEGIN
	IF ISNULL(@ID,0) = 0
	BEGIN
		INSERT INTO patient_family_hx_external 
		(pfhe_pat_id,pfhe_member_relation_id,pfhe_problem,pfhe_dr_id,
		pfhe_added_by_dr_id,pfhe_created_on,pfhe_enable,
		 pfhe_icd10, pfhe_icd10_description, pfhe_snomed,
		 pfhe_snomed_description, last_modified_on, last_modified_by)
        VALUES (@PatientId,@MemeberRelationId,@problem,@DocotorId,@AddedByDrID,@CreatedOn,@IsEnable,
       @ICD10, @ICD10Description, @SNOMED, @SNOMEDDescription, GETDATE(),@AddedByDrID); 
        SET @ID = SCOPE_IDENTITY();
	END 
	ELSE
	BEGIN
		UPDATE patient_family_hx_external 
		SET pfhe_pat_id=@PatientId,
		pfhe_member_relation_id=@MemeberRelationId,
		pfhe_problem=@Problem,
		pfhe_icd10 = @ICD10,	
		pfhe_icd10_description = @ICD10Description,
		pfhe_snomed = @SNOMED,
		pfhe_snomed_description = @SNOMEDDescription,
		last_modified_on=GETDATE(),
		last_modified_by=@AddedByDrID,
		pfhe_enable=@IsEnable,
		pfhe_created_on=@CreatedOn 
		WHERE pfhe_pat_id=@PatientId AND pfhe_fhxid=@ID;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
