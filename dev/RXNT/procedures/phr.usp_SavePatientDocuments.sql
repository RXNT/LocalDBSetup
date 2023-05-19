SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 13.12.2017
-- Description: Save Patient Documents
-- =============================================
CREATE PROCEDURE [phr].[usp_SavePatientDocuments]	
    @DocumentId  BIGINT OUTPUT,
	@Title		VARCHAR(500),
	@Description	VARCHAR(500),
	@PatientId		BIGINT,
	@DoctorId	BIGINT,
	@DoctorCompanyId	BIGINT,
	@FileName		VARCHAR(225),
	@FilePath		VARCHAR(500),
	@PatientRepresentativeId		BIGINT

	
AS
BEGIN

INSERT INTO [phr].[PatientPortalDocuments] (PatientId,DoctorId,DoctorCompanyId, PatientRepresentativeId, Title,Description,FilePath,FileName,Active,CreatedDate) 
          VALUES (@PatientId, @DoctorId, @DoctorCompanyId, @PatientRepresentativeId, @Title, @Description,@FilePath, @FileName, 1, GETDATE()) 
SELECT @DocumentId=SCOPE_IDENTITY();          

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
