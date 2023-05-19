SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: KANNIYAPPAN NARASIMAN
-- Create date	: 20-Jun-2016
-- Description	: to update Login Filtered on Doctor Company
-- =============================================
CREATE PROCEDURE [adm].[usp_UpdateExternalRegisterUser]
(
	@DocotorId					INT OUTPUT,
	@CompanyId					INT,
	@GroupId					INT,
	
	@Username					VARCHAR(50),
	@Prefix						VARCHAR(10),
	@FirstName					VARCHAR(50),
	@MiddleInitial				VARCHAR(20),
	@LastName					VARCHAR(50),
	@Address1					VARCHAR(100),
	@Address2					VARCHAR(100),
	@CityId						VARCHAR(50),
	@StateId					VARCHAR(30),
	@ZipCode					VARCHAR(20),
	@Phone						VARCHAR(30),
	@PhoneAlt1					VARCHAR(30),
	@PhoneAlt2					VARCHAR(30),
	@PhoneEmgcy					VARCHAR(30),
	@Fax						VARCHAR(30),
	@Email						VARCHAR(50),
	@Active						BIT,
	@ConcurrencyErr				BIT OUTPUT,
	@ProfDesignation            VARCHAR(50) = NULL,
	@Level4						INT = NULL,
	@RightMask                  BIGINT = NULL,
	@SecurityGroup              INT = NULL,
	@PrescribingAuthority       INT = NULL,
	@EnableV2Dashboard			BIT = NULL,	--Added by Nambi for RS-4920 & RS-4923
	@EnableV2EncounterTemplate	BIT = NULL,	--Added by Rajaram for TemplateEngine Project
	@EnableRulesEngine			BIT = NULL,	--Added by Vidya for RulesEngine Project
	@Suffix						VARCHAR(20) = NULL,
	@NPI						VARCHAR(30) = NULL,
	@MedicalLicenseNumber		VARCHAR(50) = NULL,
	@MedicalLicenseState		VARCHAR(30) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Rights BIGINT; 
	DECLARE @LicNumber VARCHAR(30) = '';
	DECLARE @LicState  VARCHAR(5) = '';
	DECLARE @SalesRepId BIGINT = NULL;
	DECLARE @PreviousdrLastAliasID BIGINT;
	SET @ConcurrencyErr = 0;
	
	BEGIN
		IF NOT EXISTS(	SELECT TOP 1 1 FROM dbo.doctors 
						WHERE dr_id	= @DocotorId
					  )
		BEGIN
				SET @ConcurrencyErr = 1;
		END

		SELECT @PreviousdrLastAliasID =  dr_last_alias_dr_id from doctors where dr_id = @DocotorId

		IF @Level4 > 0 AND @Level4 <> @PreviousdrLastAliasID
		BEGIN
	      SELECT @LicNumber = dr_lic_numb, @LicState = dr_lic_state, @SalesRepId = sales_person_id from doctors where dr_id = @Level4
	    END
		ELSE
		BEGIN
		  SELECT @LicNumber = dr_lic_numb, @LicState = dr_lic_state, @SalesRepId = sales_person_id from doctors where dr_id = @DocotorId
		END
		
		IF @MedicalLicenseNumber IS NOT NULL
		BEGIN
			SET @LicNumber = @MedicalLicenseNumber
		END
		
		IF @MedicalLicenseState IS NOT NULL
		BEGIN
			SET @LicState = @MedicalLicenseState
		END
			
		IF @ConcurrencyErr = 0
		BEGIN
		 IF @ZipCode = '00001' OR @CityId = 'No City' OR @StateId = 'OO'
		  BEGIN
			UPDATE dbo.doctors
			SET	dg_id				= @GroupId,
				dr_username			= @Username,
				dr_prefix			= @Prefix,
				dr_first_name		= @FirstName,
				dr_middle_initial	= @MiddleInitial ,
				dr_last_name		= @LastName,
				dr_address1			= @Address1,
				dr_address2			= @Address2,
				--dr_city				= @CityId,
				--dr_state				= @StateId,
				--dr_zip				= @ZipCode,
				dr_phone			= @Phone,
				dr_phone_alt1		= @PhoneAlt1,
				dr_phone_alt2		= @PhoneAlt2,
				dr_phone_emerg		= @PhoneEmgcy,
				dr_fax				= @Fax,
				dr_email			= @Email,
				professional_designation= ISNULL(@ProfDesignation,professional_designation),
				prescribing_authority=ISNULL(@PrescribingAuthority,prescribing_authority),
				dr_last_alias_dr_id=ISNULL(@Level4,dr_last_alias_dr_id),
				rights = ISNULL(ISNULL(@RightMask,rights),638975),
				dr_lic_numb         = @LicNumber,
				dr_lic_state        = @LicState,
				sales_person_id     = @SalesRepId,
				dr_suffix			= @Suffix,
				NPI					= @NPI 
			WHERE	  dr_id		 = @DocotorId
				 
		  END
		  ELSE
		  BEGIN
			UPDATE dbo.doctors
			SET	dg_id				= @GroupId,
				dr_username			= @Username,
				dr_prefix			= @Prefix,
				dr_first_name		= @FirstName,
				dr_middle_initial	= @MiddleInitial ,
				dr_last_name		= @LastName,
				dr_address1			= @Address1,
				dr_address2			= @Address2,
				dr_city				= @CityId,
				dr_state			= @StateId,
				dr_zip				= @ZipCode,
				dr_phone			= @Phone,
				dr_phone_alt1		= @PhoneAlt1,
				dr_phone_alt2		= @PhoneAlt2,
				dr_phone_emerg		= @PhoneEmgcy,
				dr_fax				= @Fax,
				dr_email			= @Email,
				professional_designation= ISNULL(@ProfDesignation,professional_designation),
				prescribing_authority=ISNULL(@PrescribingAuthority,prescribing_authority),
				dr_last_alias_dr_id=ISNULL(@Level4,dr_last_alias_dr_id),
				rights = ISNULL(ISNULL(@RightMask,rights),638975),
				dr_lic_numb         = @LicNumber,
				dr_lic_state        = @LicState,
				sales_person_id     = @SalesRepId  ,
				dr_suffix			= @Suffix,
				NPI					= @NPI
			WHERE	  dr_id		 = @DocotorId
				 
	  
		END

		-- To trigger surescripts directory update
		UPDATE dbo.doc_admin SET update_date=GETDATE() WHERE dr_id = @DocotorId AND dr_partner_participant = 262144
   
   -- Security Group Activation and DeActivation Process
   --SS-2215
  IF @SecurityGroup IS NOT NULL
	BEGIN
		DELETE FROM doc_security_group_members where dr_id=@DocotorId and dsg_id in (1,3,15)
	END
   		
   IF @SecurityGroup = 0
	BEGIN
		INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,1);
	END
	ELSE IF @SecurityGroup = 1
	BEGIN
        INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,3);
	END
	ELSE IF @SecurityGroup = 3
	BEGIN
      INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,1);
      INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,3);
	END
	ELSE IF @SecurityGroup = 4
	BEGIN
		INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,3);
	    INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,15);
	END
	ELSE IF @SecurityGroup = 5
	BEGIN
	    INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,15);
	END
	ELSE IF @SecurityGroup = 6
	BEGIN
		INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,1);
	    INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,15);
	END
	ELSE IF @SecurityGroup = 7
	BEGIN
		INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,1);
		INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,3);
	    INSERT INTO doc_security_group_members (dr_id, dsg_id) VALUES (@DocotorId,15);
	END

--Added by Nambi for RS-4920 & RS-4923
	IF @EnableV2Dashboard IS NOT NULL
	BEGIN
		IF @EnableV2Dashboard = 1 
			BEGIN
				UPDATE doctor_info
				SET is_custom_tester = is_custom_tester ^ 1
				WHERE 1 = 1
				AND dr_id = @DocotorId
				AND (is_custom_tester & 1) = 1
				
				UPDATE doctor_info
				SET is_custom_tester = is_custom_tester | 4
				WHERE 1 = 1
				AND dr_id = @DocotorId
				AND (is_custom_tester & 4) <> 4
				
				UPDATE doctor_info
				SET is_custom_tester = is_custom_tester | 8
				WHERE 1 = 1
				AND dr_id = @DocotorId
				AND (is_custom_tester & 8) <> 8
				
				--UPDATE doctor_info
				--SET is_custom_tester = is_custom_tester | 16
				--WHERE 1 = 1
				--AND dr_id = @DocotorId
				--AND (is_custom_tester & 16) <> 16

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

				--Added by Rajaram for TemplateEngine Project End
				
				UPDATE doctor_info
				SET encounter_version = @EncounterVersion
				WHERE 1 = 1
				AND dr_id = @DocotorId
			END
		ELSE
			BEGIN
				UPDATE doctor_info
				SET is_custom_tester = is_custom_tester ^ 4
				WHERE 1 = 1
				AND dr_id = @DocotorId
				AND (is_custom_tester & 4) = 4
				
				UPDATE doctor_info
				SET is_custom_tester = is_custom_tester ^ 8
				WHERE 1 = 1
				AND dr_id = @DocotorId
				AND (is_custom_tester & 8) = 8
				
				IF NOT EXISTS(SELECT TOP 1 1 
				FROM doc_companies dc WITH(NOLOCK) 
				INNER JOIN doc_groups dg WITH(NOLOCK) ON dc.dc_id=dg.dc_id 
				INNER JOIN doctors dr  WITH(NOLOCK) ON dr.dg_id=dg.dg_id
				WHERE dr.dr_id = @DocotorId AND dc.is_custom_tester=1)
				BEGIN
					UPDATE doctor_info
					SET is_custom_tester = is_custom_tester ^ 16
					WHERE 1 = 1
					AND dr_id = @DocotorId
					AND (is_custom_tester & 16) = 16
				END
				
				UPDATE doctor_info
				SET is_custom_tester = is_custom_tester | 1
				WHERE 1 = 1
				AND dr_id = @DocotorId
				AND (is_custom_tester & 1) <> 1
			END
	END	

	UPDATE doctor_info
	SET EnableRulesEngine = @EnableRulesEngine --Added by Vidya for RulesEngine Project
	WHERE 1 = 1
	AND dr_id = @DocotorId
	
--Added by Nambi for RS-4920 & RS-4923 Ends		
	END
END	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
