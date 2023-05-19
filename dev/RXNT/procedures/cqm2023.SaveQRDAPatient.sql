SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================

-- Author:			Rasheed

-- Create date: 	03-NOV-2022

-- Description:		Save QRDA Patient

-- =============================================

CREATE    PROCEDURE [cqm2023].[SaveQRDAPatient]

  @PatientId			BIGINT,

  @DGID					BIGINT,

  @DRID					BIGINT,

  @Prefix				VARCHAR(30),

  @Suffix				VARCHAR(30),

  @FirstName			VARCHAR(50),

  @MiddleName			VARCHAR(50),

  @LastName				VARCHAR(50),

  @ChartNo				VARCHAR(30),

  @DOB					SMALLDATETIME,

  @Address1				VARCHAR(50),

  @Address2				VARCHAR(50),

  @City					VARCHAR(30),

  @State				VARCHAR(30),

  @Zip					VARCHAR(30),

  @HomePhone			VARCHAR(30),

  @Sex					VARCHAR(10),

  @Flag					TINYINT,

  @ExternalSSN			VARCHAR(30),

  @InsType				TINYINT,

  @Race					VARCHAR(20),

  @Ethnicity			VARCHAR(20),

  @Language				VARCHAR(20),

  @Email				VARCHAR(50),

  @AddedByUser			INT,

  @OwnerType			VARCHAR(30)

AS

BEGIN

	DECLARE @RaceCodeSystemId AS BIGINT

	DECLARE @RaceId AS TINYINT

	DECLARE @EthnicityId AS TINYINT

	DECLARE @LanguageId AS SMALLINT=1

	

	IF @Race IS NOT NULL

	BEGIN

		SELECT @RaceId = slc.ApplicationTableConstantCode FROM ehr.SysLookupCodes slc WITH(NOLOCK)

		INNER JOIN ehr.SysLookupCodeSystem slcs WITH(NOLOCK) ON slc.CodeSystemId=slcs.CodeSystemId

		WHERE slc.Code=@Race AND slcs.ApplicationTableCode='PARCA'

	END

	

	IF @Ethnicity IS NOT NULL

	BEGIN

		SELECT @EthnicityId = slc.ApplicationTableConstantCode FROM ehr.SysLookupCodes slc WITH(NOLOCK)

		INNER JOIN ehr.SysLookupCodeSystem slcs WITH(NOLOCK) ON slc.CodeSystemId=slcs.CodeSystemId

		WHERE slc.Code=@Ethnicity AND slcs.ApplicationTableCode='PAETN'

	END

	

	--IF @Language IS NOT NULL

	--BEGIN

	--	SELECT @LanguageId=atc.Code FROM ehr.SysLookupCodes slc WITH(NOLOCK)

	--	INNER JOIN ehr.ApplicationTableConstants atc WITH(NOLOCK) ON slc.ApplicationTableConstantId=atc.ApplicationTableConstantId

	--	INNER JOIN ehr.ApplicationTables at WITH(NOLOCK) ON atc.ApplicationTableId=at.ApplicationTableId

	--	WHERE slc.Code=@Language

	--END

	

	INSERT INTO PATIENTS(dg_id, dr_id, pa_prefix, pa_suffix, pa_first, pa_middle, pa_last, pa_ssn, pa_dob, pa_address1, pa_address2, pa_city, pa_state, 

	pa_zip, pa_phone, pa_sex, pa_flag, pa_ext_ssn_no, pa_ins_type, pa_race_type, pa_ethn_type, pref_lang, pa_email,add_by_user, OwnerType)

	VALUES (@DGID, @DRID, @Prefix, @Suffix , @FirstName, @MiddleName, @LastName, @ChartNo, @DOB, @Address1, @Address2, @City, @State, 

	@Zip, @HomePhone, @Sex, @Flag, @ExternalSSN, @InsType, @RaceId, @EthnicityId, @LanguageId, @Email,@AddedByUser, @OwnerType)

	

	SET @PatientId = SCOPE_IDENTITY()

	SELECT @PatientId as PatientId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
