SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vikas
-- Create date: 25-Mar-2015
-- Description:	to fetch list of external users
-- Modified	By: Kanniyappan
-- Modified Date : 18-May-2016
-- Description:	Added DoctorCompanyId columns for Admin V2
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchUsers]
	@IncludeDeleted				BIT		= 0,
	@CompanyId					BIGINT	= NULL,
	@GroupId					BIGINT	= NULL,
	@DoctorId					BIGINT	= NULL,
	@GroupName					VARCHAR(50) = NULL,
	@LastName					VARCHAR(50) = NULL,
	@FirstName					VARCHAR(50) = NULL,
	@UserName					VARCHAR(50) = NULL,
	@Email						VARCHAR(50) = NULL,
	@PrescribingAuthority		INT = NULL
AS

BEGIN
	SET NOCOUNT ON;

	SELECT	GS.dc_Id AS DoctorCompanyId,
			RU.dr_id AS LoginId,
			RU.dr_username As UserName,
			RU.dr_password AS PassCode,
			RU.dr_prefix AS Prefix,
			RU.dr_first_name AS FirstName,
			RU.dr_middle_initial AS MiddleName,
			RU.dr_last_name AS LastName,
			RU.dr_address1 AS Address1,
			RU.dr_address2 AS Address2,
			RU.dr_city AS City,
			RU.dr_state AS [State],
			RU.dr_zip AS [ZipCode],
			RU.dr_phone AS Phone,
			RU.dr_phone_alt1 AS Phone1,
			RU.dr_phone_alt2 AS Phone2,
			RU.dr_phone_emerg AS PhoneEmerg,
			RU.dr_fax AS FAX,
			RU.dr_email AS Email,
			DC.dc_name As DoctorCompanyName,
			GS.Dg_id As GroupId,
			GS.dg_name As GroupName,
			ISNULL(RU.password_expiry_date,DATEADD(day,360,GETDATE())) AS PasswordExpiryDate,
			RU.dr_enabled AS Active,
			RU.professional_designation AS professionalDesignation,
			RU.prescribing_authority AS prescribingAuthority,
			RU.dr_last_alias_dr_id AS DoctorAliasId,
			CASE WHEN (DI.is_custom_tester & 4) = 4 OR (DI.is_custom_tester & 8) = 8 THEN 1 ELSE 0 END as EnableV2Dashboard,
			DI.encounter_version,
			DI.EnableRulesEngine,
			RU.rights AS Rights,
			dr_suffix AS Suffix,
			RU.NPI AS NPI,
			dr_lic_numb AS MedicalLicenseNumber,
			dr_lic_state AS MedicalLicenseState,

			RU.dr_dea_numb,
			RU.dr_dea_suffix,
			RU.dr_dea_hidden,
			DI.dr_dea_address1,
			DI.dr_dea_address2,
			DI.dr_dea_city,
			DI.dr_dea_state,
			DI.dr_dea_zip,
			DI.dr_dea_first_name,
			DI.dr_dea_middle_initial,
			DI.dr_dea_last_name,
			DI.dr_dea_certificate_external_id,
			DI.dr_dea_certificate_file_name,
			DI.dr_alternate_name_registered,
			DI.dr_prescribe_suboxone,
			DI.is_institutional_dea
	FROM doctors RU WITH(NOLOCK)
	INNER JOIN doctor_info DI with(nolock) on RU.dr_id=DI.dr_id	--Added by Nambi for RS-4920 & RS-4923
	INNER JOIN doc_groups GS WITH(NOLOCK) ON RU.dg_id=GS.Dg_id
	INNER JOIN doc_companies DC WITH(NOLOCK) ON GS.dc_id=DC.Dc_id
	WHERE (GS.dc_Id = @CompanyId OR ISNULL(@CompanyId, 0) = 0)
	AND	  (RU.dr_id = @DoctorId OR ISNULL(@DoctorId, 0) = 0)
	AND	  (GS.dg_id = @GroupId OR ISNULL(@GroupId, 0) = 0)
	AND		((@IncludeDeleted = 1) OR (@IncludeDeleted = 0 AND RU.DR_ENABLED = 1))
	AND  (GS.dg_name LIKE '%' + @GroupName  + '%' OR @GroupName IS NULL)
	AND  (RU.dr_last_name LIKE '%' + @LastName  + '%' OR @LastName IS NULL)
	AND	 (RU.dr_first_name LIKE '%' + @FirstName  + '%' OR @FirstName IS NULL)
	AND	 (RU.dr_username LIKE '%' + @UserName  + '%' OR @UserName IS NULL)
	AND	 (RU.dr_email LIKE '%' + @Email  + '%' OR @Email IS NULL)
	AND	 (@PrescribingAuthority IS NULL OR RU.prescribing_authority=@PrescribingAuthority)
	
	SELECT DISTINCT doc_security_group_members.dsg_id, doc_security_group_members.dr_id, doc_security_groups.dsg_desc 
     FROM doc_security_groups INNER JOIN doc_security_group_members ON doc_security_groups.dsg_id = doc_security_group_members.dsg_id 
     WHERE doc_security_group_members.dr_id = @DoctorId 
     ORDER BY doc_security_groups.dsg_desc

   SELECT [dr_admin_id]
      ,[dr_id]
      ,[dr_partner_participant]
      ,[dr_service_level]
      ,[dr_partner_enabled]
      ,[report_date]
      ,[update_date]
      ,[fail_lock]
      ,[version]
  FROM [dbo].[doc_admin] WITH (NOLOCK)
   WHERE dr_id = @DoctorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
