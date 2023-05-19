SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 01/13/2022
-- Description:	Checks if the entry with the supplied parameters exists in the patient external app map table
--				This is used to verify the providers authenticating to PHR with their credentials can only access data 
--				that belongs to the same doctor company
-- =============================================
CREATE PROCEDURE [phr].[usp_ValidatePatientAndCompanyInfo]
	@V2PatientId INT,
	@V2CompanyId INT,
	@V1PatientId INT,
	@V1CompanyId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT 1
		FROM [dbo].[RsynMasterPatientExternalAppMaps] with(nolock)
		WHERE 
		PatientId = @V2PatientId AND
		ExternalPatientId = @V1PatientId AND
		CompanyId = @V2CompanyId AND
		ExternalDoctorCompanyId = @V1CompanyId
			
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
