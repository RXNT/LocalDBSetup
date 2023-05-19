SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	13-DEC-2017
-- Description:		Accept or Ignore Patient Portal Documents
-- =============================================
CREATE PROCEDURE [prv].[AcceptOrIgnorePatientPortalDocuments]
	@DoctorId								BIGINT,
	@DoctorCompanyId						BIGINT,
	@IsAccepted								BIT=0,
	@PatientPortalDocumentId				BIGINT,
	@Comments								VARCHAR(255)=NULL
AS
BEGIN
 
  DECLARE @CategoryId AS BIGINT=0
  DECLARE @PatientDocumentId AS BIGINT=0
  
  IF (@IsAccepted=1)
  BEGIN
	  SELECT TOP 1 @CategoryId=cat_id FROM patient_documents_category WHERE title LIKE 'Patient Portal Documents'
	  
	  INSERT INTO [patient_documents] 
	  ([pat_id],[src_dr_id],[upload_date],[title],[description],[filename],[cat_id],[owner_id],[owner_type])
	  SELECT TOP 1 PatientId, DoctorId, CreatedDate, Title, Description, FilePath,@CategoryId,NULL,NULL
	  FROM [phr].[PatientPortalDocuments]
	  WHERE PatientPortalDocumentId = @PatientPortalDocumentId AND DoctorId = @DoctorId AND DoctorCompanyId=@DoctorCompanyId
	  AND Active=1 AND IsAccepted IS NULL AND DocumentId IS NULL
	  
	  SELECT @PatientDocumentId=SCOPE_IDENTITY();
	  
	  UPDATE [phr].[PatientPortalDocuments] SET IsAccepted=1, ActionDate=GETDATE(), DocumentId=@PatientDocumentId
	  WHERE PatientPortalDocumentId=@PatientPortalDocumentId AND DoctorId=@DoctorId AND DoctorCompanyId=@DoctorCompanyId
	  
  END
  ELSE
  BEGIN
  
	UPDATE [phr].[PatientPortalDocuments] SET IsAccepted=0, ActionDate=GETDATE(), Comments=@Comments
	WHERE PatientPortalDocumentId=@PatientPortalDocumentId AND DoctorId=@DoctorId AND DoctorCompanyId=@DoctorCompanyId AND Active=1
	
  END
  
  
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
