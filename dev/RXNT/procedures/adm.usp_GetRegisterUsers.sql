SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kanniyappan N
-- Create date: 07-Oct-2016
-- Description:	to fetch list of external users
-- Modified	By: 
-- Modified Date : 
-- Description:	
-- =============================================
CREATE PROCEDURE [adm].[usp_GetRegisterUsers]
	@DoctorId			BIGINT
	
	
AS

BEGIN
	SET NOCOUNT ON;

	SELECT	RU.dr_first_name AS FirstName,
			RU.dr_last_name AS LastName,
			RU.dr_speciality_code AS Speciality,
			RU.professional_designation AS ProfessionalDesignation,
			RU.dr_lic_numb AS LicenseNumber,
			RU.dr_lic_state AS LicenseState,
			RU.NPI	AS NPINumber,
			
			RU.dr_address1 AS [Address],
			RU.dr_city AS City,
			RU.dr_state AS [State],
			RU.dr_zip AS [ZipCode],
			CASE WHEN LEN(RU.timezone) < 1 THEN 'EST' ELSE RU.timezone END AS TimeZone,
			RU.dr_phone AS Phone,
			RU.dr_fax AS FAX,
			RU.office_contact_name AS OfficeContactName,
			RU.office_contact_email AS OfficeContactEmail,
			RU.office_contact_phone AS OfficeContactPhone,
			
			RU.dr_dea_numb AS DEANumber,
			DI.dr_dea_first_name AS DEAFirstName,
			DI.dr_dea_middle_initial AS DEAMiddleInitial,
			DI.dr_dea_last_name AS DEALastName,
			DI.dr_dea_address1 AS DEAAddress,
			DI.dr_dea_city AS DEACity,
			DI.dr_dea_state AS DEAState,
			DI.dr_dea_zip AS DEAZipCode,
			
			RU.prescribing_authority AS PrescribingAuthority,
			RU.dr_status AS ActivationStatus,
			RU.sales_person_id AS SalesPersonInfo,
			RU.dr_enabled AS Active
			
			
	FROM doctors RU
	INNER JOIN doctor_info DI ON RU.dr_id=DI.dr_id
	Where (RU.dr_id = @DoctorId OR ISNULL(@DoctorId, 0) = 0)
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
