SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 14-Jul-2016
-- Description:	Save patient Family Hx
-- Description:	Remove icd9
-- Modified By: JahabarYusuff M
-- Modified Date: 31-Nov-2022
-- =============================================
CREATE PROCEDURE [ehr].[usp_SavePatientFamilyHx]
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
	@IsEnable BIT,
	@LivingStatus VARCHAR(MAX)
AS
BEGIN
	IF ISNULL(@ID,0) = 0
	BEGIN
		INSERT INTO patient_family_hx 
		(pat_id,member_relation_id,problem,dr_id,added_by_dr_id,created_on,enable,
		 icd10, icd10_description, snomed, snomed_description, last_modified_on, last_modified_by,LivingStatus)
        VALUES (@PatientId,@MemeberRelationId,@problem,@DocotorId,@AddedByDrID,@CreatedOn,@IsEnable,
          @ICD10, @ICD10Description, @SNOMED, @SNOMEDDescription, GETDATE(),@AddedByDrID,@LivingStatus); 
        SET @ID = SCOPE_IDENTITY();
	END 
	ELSE
	BEGIN
		UPDATE patient_family_hx 
		SET pat_id=@PatientId,
		member_relation_id=@MemeberRelationId,
		problem=@Problem,

		icd10 = @ICD10,	
		icd10_description = @ICD10Description,
		snomed = @SNOMED,
		snomed_description = @SNOMEDDescription,
		last_modified_on=GETDATE(),
		last_modified_by=@AddedByDrID,
		enable=@IsEnable,
		created_on=@CreatedOn,
		LivingStatus=@LivingStatus 
		WHERE pat_id=@PatientId AND fhxid=@ID;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
