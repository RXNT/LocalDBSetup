SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram
-- Create date: 23-OCT-2019
-- Description:	Save DEA Information
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveDEAInformation]
(
	@DocotorId					BIGINT,
	@DeaNumber					VARCHAR(100) = NULL,
	@DeaSuffix					VARCHAR(100) = NULL,
	@Address1					VARCHAR(100) = NULL,
	@Address2					VARCHAR(100) = NULL,
	@City						VARCHAR(50) = NULL,
	@State			            VARCHAR(50) = NULL,
	@Zip		                VARCHAR(50) = NULL,

	@AlternateNameRegistered	BIT,
	@AlternateFirstName			VARCHAR(50) = NULL,
	@AlternateMiddleInitial		VARCHAR(50) = NULL,
	@AlternateLastName			VARCHAR(50) = NULL,
	
	@PrescribeSuboxone	BIT,

	@DeaCertificateFileExternalId VARCHAR(100) = NULL,
	@DeaCertificateFileName VARCHAR(100) = NULL,
	
	@HideDeaNumberOnPrescription BIT,
	@IsInstitutionalDea BIT
)
AS

BEGIN
	SET NOCOUNT ON;

	UPDATE dbo.doctors
	SET	
		dr_dea_numb         = @DeaNumber,
		dr_dea_hidden		= @HideDeaNumberOnPrescription,
		dr_dea_suffix		= @DeaSuffix
	WHERE dr_id = @DocotorId

	UPDATE doctor_info
		SET dr_dea_address1 = @Address1 , 
		    dr_dea_address2 = @Address2,
			dr_dea_city = @City,
			dr_dea_state = @State,
			dr_dea_zip = @Zip,
			dr_alternate_name_registered = @AlternateNameRegistered,
			dr_dea_first_name = @AlternateFirstName,
			dr_dea_middle_initial = @AlternateMiddleInitial,
			dr_dea_last_name = @AlternateLastName,
			dr_prescribe_suboxone = @PrescribeSuboxone,
			is_institutional_dea = @IsInstitutionalDea,
			dr_dea_certificate_external_id = @DeaCertificateFileExternalId,
			dr_dea_certificate_file_name = @DeaCertificateFileName
		WHERE dr_id = @DocotorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
