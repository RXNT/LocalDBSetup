SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ============================================= 
-- Author		: Kanniyappan Narasiman 
-- Create date	: 23-Feb-2015
-- Description	: Save or Update Doctor Company
-- ============================================= 
 
CREATE PROCEDURE [adm].[usp_SaveExternalDoctorCompany]
( 
	@DoctorCompanyId	INT OUTPUT, 
	@Name				VARCHAR(80), 
	@LoggedInUserId		BIGINT, 
	@ConcurrencyErr		BIT = 0 OUTPUT,
	@EnableV2Dashboard BIT = NULL,	--Added by Nambi for RS-4920 & RS-4923
	@EnableV2EncounterTemplate BIT = 0,	--Added by Rajaram for TemplateEngine Project
	@EnableRulesEngine BIT = NULL,	--Added by Vidya for RulesEngine Project
	@ServerId		BIGINT = NULL 
) 
AS 
BEGIN 
	SET NOCOUNT ON; 
	-- Insert/Update on master database tables starts here 

	SET @ConcurrencyErr=0; 
	IF ISNULL (@DoctorCompanyId,0) = 0 
	BEGIN
	IF(ISNULL(@ServerId,0) <= 0)
	BEGIN 
		SET @ServerId = 1
	END
		INSERT INTO dbo.doc_companies
			(
			 dc_name,
			 admin_company_id,
			 is_custom_tester,
			 EnableV2EncounterTemplate,
			 EnableRulesEngine,
			 dc_host_id) --Added by Vidya Rules Engine 
		VALUES 
		   ( 
			@Name,
			@LoggedInUserId,
			@EnableV2Dashboard,
			@EnableV2EncounterTemplate,
			@EnableRulesEngine,
			@ServerId) 
			SET @DoctorCompanyId = SCOPE_IDENTITY(); 
		
	END
	ELSE 
	BEGIN 
		SET @ConcurrencyErr=0; 
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.doc_companies 
		WHERE dc_id = @DoctorCompanyId) 
		BEGIN 
			SET @ConcurrencyErr=1; 
		END 
		IF @ConcurrencyErr = 0 
		BEGIN 
		DECLARE @HOSTID BIGINT

			SELECT TOP 1 @HOSTID = ISNULL(dc_host_id,0) from dbo.doc_companies WHERE dc_id = @DoctorCompanyId

			IF(@ServerId > 0 )
			BEGIN 
				SET @HOSTID = @ServerId
			END

			UPDATE	dbo.doc_companies 
			SET		dc_name			   = @Name,
					is_custom_tester = @EnableV2Dashboard,			--Added by Nambi for RS-4920 & RS-4923	
					EnableV2EncounterTemplate = @EnableV2EncounterTemplate, --Added by Rajaram for TemplateEngine Project
					EnableRulesEngine = @EnableRulesEngine, --Added by Vidya Rules Engine
					dc_host_id = @HOSTID
			WHERE	dc_id		       = @DoctorCompanyId 
		END
		--Added by Nambi for RS-4920 & RS-4923	
		IF @EnableV2Dashboard IS NOT NULL
		BEGIN
			IF @EnableV2Dashboard = 1
				BEGIN
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester ^ 1
					FROM doctor_info doc_info WITH(NOLOCK)
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId
					AND (doc_info.is_custom_tester & 1) = 1
						
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester | 4
					FROM doctor_info doc_info WITH(NOLOCK)
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId
					AND (doc_info.is_custom_tester & 4) <> 4
						
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester | 8
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId
					AND (doc_info.is_custom_tester & 8) <> 8
						
					--UPDATE doc_info
					--SET is_custom_tester = doc_info.is_custom_tester | 16
					--FROM doctor_info doc_info
					--INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					--INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					--INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					--WHERE doc_cmp.dc_id=@DoctorCompanyId
					--AND (doc_info.is_custom_tester & 16) <> 16
				END
			ELSE
				BEGIN
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester ^ 4
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId
					AND (doc_info.is_custom_tester & 4) = 4
						
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester ^ 8
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId
					AND (doc_info.is_custom_tester & 8) = 8
						
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester ^ 16
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId
					AND (doc_info.is_custom_tester & 16) = 16
						
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester | 1
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId
					AND (doc_info.is_custom_tester & 1) <> 1
				END
			--Added by Nambi for RS-4920 & RS-4923 Ends
		END

		--Added by Rajaram for TemplateEngine Project Starts

		DECLARE @EncounterVersion VARCHAR(5)

		IF @EnableV2EncounterTemplate IS NOT NULL AND @EnableV2EncounterTemplate = 1
		BEGIN
			SET @EncounterVersion = 'v2.0'
		END
		ELSE
		BEGIN
			SET @EncounterVersion = 'v1.1'
		END

		UPDATE doc_info
		SET encounter_version = @EncounterVersion
		FROM doctor_info doc_info
		INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
		INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
		INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
		WHERE doc_cmp.dc_id=@DoctorCompanyId

		--Added by Rajaram for TemplateEngine Project End

		UPDATE doc_info
		SET EnableRulesEngine = @EnableRulesEngine --Added by Vidya for RulesEngine Project
		FROM doctor_info doc_info
		INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
		INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
		INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
		WHERE doc_cmp.dc_id=@DoctorCompanyId
	END 
	
	-- Insert/Update on master database tables ends here
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
