SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: KANNIYAPPAN NARASIMAN
-- Create date	: 20-Jun-2016
-- Description	: to save Login Filtered on Doctor Company
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveExternalRegisterUser]
(
	@DocotorId					INT OUTPUT,
	@CompanyId					INT,
	@GroupId					INT = NULL,
	@Level4						INT = NULL,
	
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
	@PasswordExpiryDate			DATETIME2,
	@Active						BIT,
	@ConcurrencyErr				BIT OUTPUT,
	@Text1						VARCHAR(50),
	@Text2						VARCHAR(250),
	@Text4						VARCHAR(250),
	@ProfDesignation            VARCHAR(50) = NULL,
	@RightMask                  BIGINT = 638975,
	@SecurityGroup              INT = NULL,
	@PrescribingAuthority       INT,
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
	SET @ConcurrencyErr = 0;
	DECLARE @Rights BIGINT;
	DECLARE @LicNumber VARCHAR(30) = '';
	DECLARE @LicState  VARCHAR(5) = '';
	DECLARE @SalesRepId BIGINT = NULL
	DECLARE @LowUsageFlag BIGINT=NULL;
	DECLARE @time_difference INT
	DECLARE @timezone VARCHAR(10)
	IF ISNULL(@DocotorId,0) = 0 
	BEGIN
		SELECT @time_difference = time_difference, 
		@timezone = time_zone
		FROM [dbo].[State] WITH(NOLOCK)
		WHERE state_code = @StateId
	END
	
	IF ISNULL(@GroupId,0) = 0 
	BEGIN
		SELECT TOP 1 @GroupId = dg_id  FROM doc_groups WHERE dc_id = @CompanyId
	END

	IF ISNULL(@Level4,0) = 0  AND @GroupId > 0
	BEGIN
		SELECT TOP 1 @Level4 = dr_id  FROM doctors with(nolock) WHERE dg_id = @GroupId and prescribing_authority=4
	END
    ELSE
	BEGIN
	   SELECT @LicNumber = dr_lic_numb, @LicState = dr_lic_state, @SalesRepId = sales_person_id from doctors where dr_id = @Level4
	END
	
	IF @MedicalLicenseNumber IS NOT NULL
	BEGIN
		SET @LicNumber = @MedicalLicenseNumber
	END
	
	IF @MedicalLicenseState IS NOT NULL
	BEGIN
		SET @LicState = @MedicalLicenseState
	END
	
	IF ISNULL(@RightMask,0) = 0 
	BEGIN
		SET @Rights = 638975;
	END
	ELSE
	BEGIN
	   SET @Rights = @RightMask;
	END

	IF ISNULL(@PrescribingAuthority,0) = 0 
	BEGIN
		SET @PrescribingAuthority = 1;
	END
	
	
	IF ISNULL(@DocotorId,0) = 0 
	BEGIN
		INSERT INTO dbo.doctors
		(dg_id
		,dr_prefix	
		,dr_first_name
		,dr_middle_initial
		,dr_last_name
		,dr_address1
		,dr_address2
		,dr_city
		,dr_state
		,dr_zip
		,dr_phone
		,dr_phone_alt1
		,dr_phone_alt2
		,dr_phone_emerg
		,dr_fax
		,dr_email
		,password_expiry_date
		,dr_enabled
		,dr_username
		,dr_password
		,salt
		,dr_create_date
		,prescribing_authority
		,rights
		,dr_status
		,dr_dea_numb
		,office_contact_email
		,office_contact_name
		,office_contact_phone
		,dr_last_alias_dr_id
		,dr_speciality_code
		,beta_tester
		,professional_designation
		,dr_lic_numb
		,dr_lic_state
		,sales_person_id
		,dr_suffix
		,NPI
		,time_difference
		,timezone)
		VALUES
		(@GroupId
		,@Prefix
		,@FirstName
		,@MiddleInitial
		,@LastName
		,@Address1
		,@Address2
		,@CityId
		,@StateId
		,@ZipCode
		,@Phone
		,@PhoneAlt1
		,@PhoneAlt2
		,@PhoneEmgcy
		,@Fax
		,@Email
		,@PasswordExpiryDate
		,@Active
		,@Text1
		,@Text2
		,@Text4
		,GETDATE()
		,@PrescribingAuthority
		,@Rights
		,7
		,''
		,'na'
		,'na'
		,'na'
		,@Level4
		,'Other'
		,1
		,@ProfDesignation
		,@LicNumber
		,@LicState
		,@SalesRepId
		,@Suffix
		,@NPI
		,@time_difference
		,@timezone)
		
		SET @DocotorId =  SCOPE_IDENTITY();
					
		INSERT INTO doctor_info(dr_id,dr_dea_first_name,dr_dea_last_name) VALUES (@DocotorId,'','')
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

					UPDATE	doctor_info
					SET		encounter_version = @EncounterVersion
					WHERE	1 = 1
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
		
		UPDATE	doctor_info
		SET		EnableRulesEngine = @EnableRulesEngine --Added by Vidya for Rules Engine Project
		WHERE	1 = 1
				AND dr_id = @DocotorId
		--Added by Nambi for RS-4920 & RS-4923 Ends
	
		SELECT TOP 1 @LowUsageFlag=UsageFlags FROM [dbo].[DoctorGroupUsageFlags]
		WHERE DoctorGroupId=@GroupId
		
		IF ISNULL(@LowUsageFlag,0)>0 AND @PrescribingAuthority >=3
		BEGIN
			DELETE FROM doc_usage_flags WHERE dr_id=@DocotorId
			INSERT INTO doc_usage_flags
			(dr_id, usage_flags)
			VALUES 
			(@DocotorId,@LowUsageFlag)
		END		 
		--Added by Niyaz for SS-2635
	END
	
	ELSE
	BEGIN
		IF NOT EXISTS(	SELECT TOP 1 1 FROM dbo.doctors 
						WHERE dr_id	= @DocotorId
						AND dg_id	= @GroupId
					  )
		BEGIN
				SET @ConcurrencyErr = 1;
		END
		
		IF @ConcurrencyErr = 0
		BEGIN
		    SELECT @LicNumber = dr_lic_numb, @LicState = dr_lic_state, @SalesRepId = sales_person_id from doctors where dr_id = @DocotorId
		    
		    IF @MedicalLicenseNumber IS NOT NULL
			BEGIN
				SET @LicNumber = @MedicalLicenseNumber
			END
			
			IF @MedicalLicenseState IS NOT NULL
			BEGIN
				SET @LicState = @MedicalLicenseState
			END

			UPDATE dbo.doctors
			SET	dr_prefix			= @Prefix,
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
				password_expiry_date= @PasswordExpiryDate ,
				dr_lic_numb         = @LicNumber,
				dr_lic_state        = @LicState,
				sales_person_id     = @SalesRepId,
				dr_suffix			= @Suffix,
				NPI					= @NPI
			WHERE	  dr_id		 = @DocotorId
				  AND dg_id		 = @GroupId
	  
		END
		
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
	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
