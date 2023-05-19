SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	Save patient Hospitalization Hx
-- Description:	Remove icd9
-- Modified By: JahabarYusuff M
-- Modified Date: 31-Nov-2022
-- =============================================
CREATE PROCEDURE [ehr].[usp_SavePatientHospitalizationHx]
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
		INSERT INTO patient_hospitalization_hx (pat_id,problem,dr_id,added_by_dr_id,created_on,last_modified_on,last_modified_by,enable,
		  icd10, icd10_description, snomed, snomed_description,source)
        VALUES (@PatientId,@problem,@DocotorId,@AddedByDrID,@CreatedOn,GETDATE(),@AddedByDrID,@IsEnable,
        @ICD10, @ICD10Description, @SNOMED, @SNOMEDDescription,@Source); 
        SET @ID =  SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE patient_hospitalization_hx 
		SET pat_id=@PatientId,
		problem=@problem,
		icd10 = @ICD10,	
		icd10_description = @ICD10Description,
		snomed = @SNOMED,
		snomed_description = @SNOMEDDescription,
		last_modified_on=GETDATE(),
		last_modified_by=@AddedByDrID,
		enable=@IsEnable, 
		created_on=@CreatedOn 
		WHERE pat_id=@PatientId AND hosphxid=@id;
	END
END

 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
