SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION calcPasswordStrength(@password VARCHAR(50))
  RETURNS INTEGER
AS
  BEGIN
    DECLARE @strength INTEGER, @index SMALLINT
    SET @index = 1
    SET @strength = 0
    WHILE (@index <= LEN(@password))
      BEGIN
        SET @strength = @strength + ASCII(SUBSTRING(@password, @index, 1))
        SET @index = @index + 1
      END
    RETURN @strength
  END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [cqm2018].[FindClosestEncounter] 
	(@Date AS DATETIME,@PatientID AS INT, @DoctorId AS INT)
RETURNS INT
AS
BEGIN
	SET @Date = DATEADD(DAY,1,CAST(CONVERT(VARCHAR(20),@Date,101) AS DATETIME))
	-- Declare variables
	DECLARE @EnounterId AS INT = 0
	
	SELECT TOP 1 @EnounterId =  enc_id
	FROM enchanced_encounter ee WITH(NOLOCK)
	WHERE ee.enc_date <= @Date AND ee.dr_id = @DoctorId AND ee.patient_id = @PatientID
	ORDER BY ee.enc_date DESC,ee.enc_id DESC
	-- Return the new converted datetime
	IF @EnounterId IS NULL
	BEGIN
		SELECT TOP 1 @EnounterId =  enc_id
		FROM enchanced_encounter ee WITH(NOLOCK)
		WHERE ee.enc_date > @Date AND ee.dr_id = @DoctorId AND ee.patient_id = @PatientID
		ORDER BY ee.enc_date DESC,ee.enc_id DESC
	END
	
	RETURN @EnounterId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [cqm2019].[FindClosestEncounter] 
	(@Date AS DATETIME,@PatientID AS INT, @DoctorId AS INT)
RETURNS INT
AS
BEGIN
	SET @Date = DATEADD(DAY,1,CAST(CONVERT(VARCHAR(20),@Date,101) AS DATETIME))
	-- Declare variables
	DECLARE @EnounterId AS INT = 0
	
	SELECT TOP 1 @EnounterId =  enc_id
	FROM enchanced_encounter ee WITH(NOLOCK)
	WHERE ee.enc_date <= @Date AND ee.dr_id = @DoctorId AND ee.patient_id = @PatientID
	ORDER BY ee.enc_date DESC,ee.enc_id DESC
	-- Return the new converted datetime
	IF @EnounterId IS NULL
	BEGIN
		SELECT TOP 1 @EnounterId =  enc_id
		FROM enchanced_encounter ee WITH(NOLOCK)
		WHERE ee.enc_date > @Date AND ee.dr_id = @DoctorId AND ee.patient_id = @PatientID
		ORDER BY ee.enc_date DESC,ee.enc_id DESC
	END
	
	RETURN @EnounterId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [cqm2022].[FindClosestEncounter] 
	(@Date AS DATETIME,@PatientID AS INT, @DoctorId AS INT)
RETURNS INT
AS
BEGIN
	SET @Date = DATEADD(DAY,1,CAST(CONVERT(VARCHAR(20),@Date,101) AS DATETIME))
	-- Declare variables
	DECLARE @EnounterId AS INT =NULL
	
	SELECT TOP 1 @EnounterId =  enc_id
	FROM enchanced_encounter ee WITH(NOLOCK)
	WHERE ee.enc_date <= @Date AND ee.dr_id = @DoctorId AND ee.patient_id = @PatientID
	ORDER BY ee.enc_date DESC,ee.enc_id DESC
	-- Return the new converted datetime
	IF @EnounterId IS NULL
	BEGIN
		SELECT TOP 1 @EnounterId =  enc_id
		FROM enchanced_encounter ee WITH(NOLOCK)
		WHERE ee.enc_date > @Date AND ee.dr_id = @DoctorId AND ee.patient_id = @PatientID
		ORDER BY ee.enc_date DESC,ee.enc_id DESC
	END
	
	RETURN @EnounterId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetDrugDetailsByName] 
( 
    @DrugName VARCHAR(255)
) 
	RETURNS @Output TABLE(DrugId BIGINT,DrugName VARCHAR(255),DrugLevel INT
) 
BEGIN 
   
    INSERT INTO @Output (DrugId,DrugName,DrugLevel)  
	SELECT TOP 1 a.medid,b.med_medid_desc,B.med_REF_DEA_CD FROM rmindc1 a WITH(NOLOCK) 
	INNER JOIN rmiid1 b  WITH(NOLOCK)  ON a.medid=b.medid 
	WHERE med_medid_desc =@DrugName+'%'
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetDrugDetailsByNDC] 
( 
    @NDC VARCHAR(50)
) 
	RETURNS @Output TABLE(DrugId BIGINT,DrugName VARCHAR(255),DrugLevel INT
) 
BEGIN 
   
    INSERT INTO @Output (DrugId,DrugName,DrugLevel)  
	SELECT TOP 1 a.medid,b.med_medid_desc,B.med_REF_DEA_CD FROM rmindc1 a WITH(NOLOCK) 
	INNER JOIN rmiid1 b  WITH(NOLOCK)  ON a.medid=b.medid 
	WHERE ndc =@NDC
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetDrugStrengthUnitCode] 
( 
    @StrengthName VARCHAR(50)
) 
RETURNS VARCHAR(50)
BEGIN 
	DECLARE @Code VARCHAR(100) 
	SELECT TOP 1 @Code=su.NCIt_unit_code 
	FROM [dbo].[drug_fdb_strength_units] fsu WITH(NOLOCK) 
	INNER JOIN [drug_strength_units] su WITH(NOLOCK) ON fsu.dsu_id=su.dsu_id
	WHERE fsu.dsu_text =@StrengthName
    RETURN  ISNULL(@Code,'C38046')
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPatientInfoByDetails] 
( 
    @DoctorCompanyId BIGINT,
    @PatientFirstName VARCHAR(50),
    @PatientLastName VARCHAR(50),
    @PatientDOB DATETIME
) 
	RETURNS @Output TABLE(PatientId BIGINT,LastName VARCHAR(50),FirstName VARCHAR(50),MiddleName VARCHAR(50),Gender VARCHAR(1),DOB DATETIME)
BEGIN 
   
    INSERT INTO @Output (PatientId,LastName,FirstName,MiddleName,Gender,DOB)  
	SELECT DISTINCT TOP 2 P.PA_ID, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, P.PA_SEX, P.pa_dob 
	FROM patients P WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id=p.dg_id 
	--LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS PE WITH(NOLOCK) ON P.PA_ID = PE.PA_ID 
	--LEFT OUTER JOIN Patient_merge_request_queue PQ WITH(NOLOCK) ON PQ.primary_pa_id=P.pa_id 
    WHERE P.PA_FIRST LIKE @PatientFirstName AND P.PA_LAST LIKE @PatientLastName AND DG.DC_ID=@DoctorCompanyId AND (@PatientDOB IS NULL OR P.PA_DOB = @PatientDOB )
    ORDER BY p.pa_last, p.pa_first
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPatientInfoById] 
( 
    @PatientId BIGINT
) 
	RETURNS @Output TABLE(PatientId BIGINT,LastName VARCHAR(50),FirstName VARCHAR(50),MiddleName VARCHAR(50),Gender VARCHAR(1),DOB DATETIME)
BEGIN 
   
    INSERT INTO @Output (PatientId,LastName,FirstName,MiddleName,Gender,DOB)  
	SELECT P.PA_ID, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, P.PA_SEX, P.pa_dob 
	FROM patients p WITH(NOLOCK)
	WHERE P.PA_ID = @PatientId
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPatientMismatchInfoHtml] 
(  
	@RxNTPatientFirstName VARCHAR(50),
    @PatientFirstName VARCHAR(50),
    @RxNTPatientLastName VARCHAR(50),
    @PatientLastName VARCHAR(50),
    @RxNTPatientDOB DATETIME,
    @PatientDOB DATETIME,
    @PatientMiddleName VARCHAR(50),
    @PatientGender VARCHAR(1),
    @PatientAddressLine1 VARCHAR(100),
    @PatientAddressLine2 VARCHAR(100)=NULL,
    @PatientCity VARCHAR(100),
    @PatientState VARCHAR(50),
    @PatientZipCode VARCHAR(50),
    @PatientPhone VARCHAR(50)
) 
	RETURNS VARCHAR(MAX)
	BEGIN 
		DECLARE @Info VARCHAR(MAX)= '<table>';
		
		SET @RxNTPatientFirstName=ISNULL(@RxNTPatientFirstName,'')
		SET @PatientFirstName=ISNULL(@PatientFirstName,'')
		SET @RxNTPatientLastName = ISNULL(@RxNTPatientLastName,'')
		SET @PatientLastName = ISNULL(@PatientLastName,'')
		SET @RxNTPatientDOB = ISNULL(@RxNTPatientDOB,GETDATE()+100)
		SET @PatientDOB = ISNULL(@RxNTPatientDOB,GETDATE()+100)
		IF LOWER(@RxNTPatientFirstName)!= LOWER(@PatientFirstName)
		BEGIN
			SET @Info = @Info+'<tr><td><div id=''mismatched''><label>First Name:</label></div></td>  <td><div id=''mismatched''> '+@PatientFirstName+'</div></td></tr>'
		END
		ELSE
		BEGIN
			SET @Info = @Info+ '<tr><td><div><label>First Name:</label></div></td>  <td> <div> '+@PatientFirstName+' </div></td></tr>'
		END
		
		IF LOWER(@RxNTPatientLastName) != LOWER(@PatientLastName)
		BEGIN
			SET @Info = @Info+ '<tr><td><div id=''mismatched''><label>Last Name:</label></div></td>  <td> <div id=''mismatched''>'+@PatientLastName+' </div></td></tr>'
		END
		ELSE
		BEGIN
			SET @Info = @Info+ '<tr><td><div><label>Last Name:</label> </div></td>  <td><div>'+@PatientLastName+'</div></td></tr>'
		END

    

		IF LEN(@PatientMiddleName)>0
			SET @Info = @Info+ '<tr><td><div><label>Middle Name:</label> </div></td>  <td><div>'+@PatientMiddleName+'</div></td></tr>'

		IF CONVERT(VARCHAR(20),@RxNTPatientDOB,101) != CONVERT(VARCHAR(20),@PatientDOB,101) 
		BEGIN 
			SET @Info = @Info+ '<tr><td><div id=''mismatched''><label>DateOfBirth:</label></div></td>  <td> <div id=''mismatched''>'+CONVERT(VARCHAR(20),@PatientDOB,101)+'</div></td></tr>'
		END
		ELSE
		BEGIN
			SET @Info = @Info+ '<tr><td><div><label>DateOfBirth:</label></div></td>  <td><div> '+CONVERT(VARCHAR(20),@PatientDOB,101)+' </div></td></tr>';
		END
		SET @Info = @Info+ '<tr><td><div><label>Sex:</label></div></td>  <td><div> '+@PatientGender+' </div></td></tr>'
		IF LEN(@PatientAddressLine1)>0
			SET @Info = @Info+ '<tr><td><div><label>Address1:</label> </div></td>  <td><div>'+@PatientAddressLine1+' </div></td></tr>'
		IF LEN(@PatientCity)>0
			SET @Info = @Info+ '<tr><td><div><label>City:</label> </div></td>  <td><div>'+@PatientCity+'</div></td></tr>'
		IF LEN(@PatientState)>0
			SET @Info = @Info+ '<tr><td><div><label>State:</label> </div></td>  <td><div>'+@PatientState+'</div></td></tr>'
		IF LEN(@PatientZipCode)>0
			SET @Info = @Info+ '<tr><td><div><label>ZipCode:</label></div></td>  <td><div>'+@PatientZipCode+'</div></td></tr>'
		IF LEN(@PatientAddressLine2)>0
			SET @Info = @Info+ '<tr><td><div><label>Address2:</label> </div></td>  <td><div>'+@PatientAddressLine2+' </div></td></tr>'

		IF LEN(@PatientPhone)>0
			SET @Info = @Info+ '<tr><td><div><label>Phone:</label> </div></td>  <td><div>'+@PatientPhone+' </div></td></tr>'
                       
		SET @Info = @Info+ '</table>';
		RETURN  @Info
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetPatientPreferredPhone] 
( 
    @PatientId VARCHAR(50)
) 
RETURNS VARCHAR(50)
BEGIN 
	DECLARE @PreferredPhone VARCHAR(100) 
	DECLARE @HomePhone VARCHAR(100) 
	DECLARE @CellPhone VARCHAR(100) 
	DECLARE @WorkPhone VARCHAR(100) 
	DECLARE @OtherPhone VARCHAR(100)
	DECLARE @PhonePreference INT 
	SELECT @HomePhone = pat.pa_phone,@CellPhone = patext.cell_phone,@WorkPhone= patext.work_phone, @OtherPhone = patext.other_phone,@PhonePreference = patext.pref_phone 
	FROM patients pat WITH(NOLOCK)
	LEFT OUTER JOIN patient_extended_details patext WITH(NOLOCK) ON pat.pa_id=patext.pa_id
	WHERE pat.pa_id=@PatientId
	
	 
	  SET @PreferredPhone = @HomePhone
            
    IF @PhonePreference > 0
    BEGIN
        IF @PhonePreference =2 AND LEN(@CellPhone)>0
        BEGIN
            SET @PreferredPhone = @CellPhone;
        END
        ELSE IF @PhonePreference =3 AND LEN(@WorkPhone)>0
        BEGIN
            SET @PreferredPhone = @WorkPhone;
        END
        ELSE IF @PhonePreference =4 AND LEN(@OtherPhone)>0
        BEGIN
            SET @PreferredPhone = @OtherPhone;
        END
    END
    IF LEN(@PreferredPhone)<=0
	BEGIN
        IF LEN(@HomePhone)>0
        BEGIN
            SET @PreferredPhone = @HomePhone
		END
		ELSE IF LEN(@CellPhone)>0
		BEGIN
			SET @PreferredPhone = @CellPhone
		END
		ELSE IF LEN(@WorkPhone)>0
		BEGIN
			SET @PreferredPhone = @WorkPhone
		END
		ELSE IF LEN(@OtherPhone)>0
		BEGIN
			SET @PreferredPhone = @OtherPhone
		END 
	END
            
    RETURN  @PreferredPhone
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPatientRxCoverageInfo] 
( 
	@PatientId	BIGINT,
	@PBMId		VARCHAR(15)=NULL,
	@PDId		BIGINT
) 
	RETURNS @Output TABLE(CardHolderLastName VARCHAR(100),BinNumber VARCHAR(100),CardHolderMiddleName VARCHAR(50),CardHolderFirstName VARCHAR(50),CardHolderID VARCHAR(50),PBMMemberNumber VARCHAR(100),PBMName VARCHAR(50),IsDirectConnect BIT)
BEGIN 
   
    
	
	DECLARE @IsDirectConnect AS BIT=0
	DECLARE @PBMName AS VARCHAR(50)=NULL
	
	SELECT TOP 1 @IsDirectConnect=ISNULL(is_direct_connect,0), @PBMName=pbm_name FROM Formularies..pbms WHERE rxhub_part_id=@PBMId ORDER BY pbm_id DESC
	
	IF @IsDirectConnect = 1
	BEGIN
		INSERT INTO @Output (CardHolderLastName,BinNumber,CardHolderMiddleName,CardHolderFirstName,CardHolderID,PBMMemberNumber,PBMName,IsDirectConnect)  
		SELECT TOP 1 PAC.card_holder_last CardHolderLastName, case when len(PAC.pa_bin) < 1 THEN PAC.pbm_member_id ELSE PAC.pa_bin END BinNumber,
		PAC.card_holder_mi CardHolderMiddleName,PAC.card_holder_first CardHolderFirstName,PAC.card_holder_id CardHolderID,PAC.pbm_member_id PBMMemberNumber
		, @PBMName AS PBMName, @IsDirectConnect AS IsDirectConnect 
		FROM patients_coverage_info_external PAC WITH(NOLOCK)
		INNER JOIN prescription_coverage_info PCI WITH(NOLOCK) ON PAC.rxhub_pbm_id=PCI.pbm_id
		WHERE PAC.rxhub_pbm_id=@PBMId AND PAC.pa_id=@PatientId AND PCI.pd_id=@PDId
		ORDER BY PAC.pci_id DESC
	END
	ELSE
	BEGIN
		INSERT INTO @Output (CardHolderLastName,BinNumber,CardHolderMiddleName,CardHolderFirstName,CardHolderID,PBMMemberNumber,PBMName,IsDirectConnect)  
		SELECT TOP 1 PAC.card_holder_last CardHolderLastName, pa_bin BinNumber,
		PAC.card_holder_mi CardHolderMiddleName,PAC.card_holder_first CardHolderFirstName,PAC.card_holder_id CardHolderID,PAC.pbm_member_id PBMMemberNumber
		, @PBMName AS PBMName, @IsDirectConnect AS IsDirectConnect FROM patients_coverage_info PAC WITH(NOLOCK)
		INNER JOIN prescription_coverage_info PCI WITH(NOLOCK) ON PAC.rxhub_pbm_id=PCI.pbm_id
		WHERE rxhub_pbm_id=@PBMId AND PAC.pa_id=@PatientId AND PCI.pd_id=@PDId
		ORDER BY PAC.pci_id DESC
	END
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPharmacyInfoByNCPDPNumber] 
( 
    @NCPDPNumber VARCHAR(50)
) 
	RETURNS @Output TABLE(PharmacyId BIGINT) 
BEGIN 
   
    INSERT INTO @Output (PharmacyId)  
	SELECT P.PHARM_ID--, P.PHARM_COMPANY_NAME, P.PHARM_ADDRESS1, P.PHARM_ADDRESS2, P.PHARM_CITY, P.PHARM_STATE, P.PHARM_ZIP, P.PHARM_PHONE, P.PHARM_FAX, P.NCPDP_NUMB, P.PHARM_PARTICIPANT, P.SERVICE_LEVEL, CASE WHEN x.pharmacy_id IS null THEN 0 ELSE 1 END MO 
	FROM pharmacies P WITH(NOLOCK) 
	LEFT OUTER JOIN pharm_mo_xref X WITH(NOLOCK) on p.pharm_id = X.pharmacy_id 
	WHERE PHARM_ENABLED=1 AND P.NCPDP_NUMB = @NCPDPNumber
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPotencyUnitByCode] 
( 
    @PotencyUnitCode VARCHAR(50)
) 
RETURNS VARCHAR(50)
BEGIN 
	DECLARE @PotencyUnit VARCHAR(100) 
	SELECT TOP 1 @PotencyUnit=du_text FROM duration_units WHERE potency_unit_code =@PotencyUnitCode
    RETURN  @PotencyUnit
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPrescriberInfoByNPI] 
( 
    @NPI VARCHAR(50)
) 
	RETURNS @Output TABLE(DoctorId BIGINT,DoctorCompanyId BIGINT,DoctorGroupId BIGINT
) 
BEGIN 
   
    INSERT INTO @Output (DoctorId,DoctorCompanyId,DoctorGroupId)  
	SELECT D.dr_id,DG.dc_id,dg.dg_id--D.DR_FIRST_NAME,dr_enabled, D.DR_PREFIX, D.DR_SUFFIX, D.NPI, D.TIME_DIFFERENCE, D.DR_MIDDLE_INITIAL, D.DR_LAST_NAME, D.DR_ID, D.DG_ID, DG.DC_ID, D.DR_ADDRESS1, D.DR_ADDRESS2, D.DR_CITY,  D.DR_STATE, D.DR_DEA_NUMB, D.DR_ZIP, D.DR_PHONE, D.DR_FAX,D.epcs_enabled, D.PRESCRIBING_AUTHORITY 
	FROM DOCTORS D WITH(NOLOCK)
	INNER JOIN DOC_GROUPS DG  WITH(NOLOCK) ON D.DG_ID = DG.DG_ID 
	WHERE D.dr_enabled=1 AND  D.NPI = @NPI
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPrescriberInfoBySPI] 
( 
    @SPI VARCHAR(50)
) 
	RETURNS @Output TABLE(DoctorId BIGINT,DoctorCompanyId BIGINT,DoctorGroupId BIGINT,IsEPCSEnabled BIT
) 
BEGIN 
   
    INSERT INTO @Output (DoctorId,DoctorCompanyId,DoctorGroupId,IsEPCSEnabled)  
	SELECT D.dr_id,DG.dc_id,dg.dg_id,D.epcs_enabled--D.DR_FIRST_NAME,dr_enabled, D.DR_PREFIX, D.DR_SUFFIX, D.NPI, D.TIME_DIFFERENCE, D.DR_MIDDLE_INITIAL, D.DR_LAST_NAME, D.DR_ID, D.DG_ID, DG.DC_ID, D.DR_ADDRESS1, D.DR_ADDRESS2, D.DR_CITY,  D.DR_STATE, D.DR_DEA_NUMB, D.DR_ZIP, D.DR_PHONE, D.DR_FAX,D.epcs_enabled, D.PRESCRIBING_AUTHORITY 
	FROM DOCTORS D WITH(NOLOCK)
	INNER JOIN DOC_GROUPS DG  WITH(NOLOCK) ON D.DG_ID = DG.DG_ID 
	WHERE D.dr_enabled=1 AND  D.SPI_ID = @SPI
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetRxInfoByRxId] 
( 
    @RxId BIGINT,
    @DoctorCompanyId BIGINT
) 
	RETURNS @Output TABLE(PatientId BIGINT,DrugId BIGINT,DoctorId BIGINT,DrugLevel INT,IsEPCSEnabled BIT,RxDetailId BIGINT
) 
BEGIN 
   
    INSERT INTO @Output (PatientId,DrugId,DoctorId,DrugLevel,IsEPCSEnabled,RxDetailId)  
	SELECT TOP 1 a.pa_id,b.ddid,a.dr_id,R.MED_REF_DEA_CD druglevel,case when c.epcs_enabled is null then 0 else c.epcs_enabled end epcs_enabled, b.pd_id 
	FROM prescriptions a with(nolock) 
	INNER JOIN prescription_details b with(nolock) ON a.pres_id=b.pres_id 
	INNER JOIN doctors c with(nolock) ON a.dr_id=c.dr_id inner join doc_groups dg ON c.dg_id=dg.dg_id 
	INNER JOIN RMIID1 R with(nolock) on b.ddid=R.medid 
	WHERE a.pres_id = @RxId AND dg.dc_id=@DoctorCompanyId
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetRxNormCode] 
( 
    @DrugId BIGINT
) 
RETURNS @Output TABLE(DrugId BIGINT,RxNormCode VARCHAR(50),RxNormCodeTypeId INT,RxNormCodeType VARCHAR(50))
BEGIN 
	DECLARE @RxNormCode VARCHAR(50),@RxNormCodeTypeId INT,@RxNormCodeType VARCHAR(50)
	DECLARE @evd_ext_vocab_id VARCHAR(50),@evd_ext_vocab_type_id VARCHAR(50),@evd_vocab_type_desc VARCHAR(50),@evd_fdb_vocab_id VARCHAR(50)
	IF EXISTS(SELECT TOP 1 * FROM rmiid1 WHERE medid=@DrugId AND med_ref_gen_drug_name_cd=2) --//is Brand
	BEGIN
		SELECT TOP 1 @evd_ext_vocab_type_id = evd_ext_vocab_type_id,@evd_vocab_type_desc = r2.evd_vocab_type_desc,@evd_ext_vocab_id=evd_ext_vocab_id,@evd_fdb_vocab_id =evd_fdb_vocab_id 
		FROM  revdel0 r1 WITH(NOLOCK) 
		INNER JOIN revdvt0 r2 WITH(NOLOCK) ON r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id 
		INNER JOIN rmiid1 r3 WITH(NOLOCK)  ON evd_fdb_vocab_id = r3.medid 
		WHERE evd_fdb_vocab_type_id=3 
		AND evd_ext_vocab_type_id IN (502,504,505)  
		AND evd_fdb_vocab_id = @DrugId 
		AND R3.med_ref_gen_drug_name_cd =  2 
	END 
	ELSE
	BEGIN
		SELECT TOP 1 @evd_ext_vocab_type_id=evd_ext_vocab_type_id,@evd_vocab_type_desc =r2.evd_vocab_type_desc,@evd_ext_vocab_id = evd_ext_vocab_id,@evd_fdb_vocab_id=evd_fdb_vocab_id 
		FROM revdel0 r1 WITH(NOLOCK) 
		INNER JOIN revdvt0 r2 WITH(NOLOCK) ON r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id 
		WHERE evd_fdb_vocab_type_id=3 AND evd_ext_vocab_type_id in (501,503) AND evd_fdb_vocab_id = @DrugId
	END
	     
    IF @evd_ext_vocab_id IS NOT NULL
    BEGIN
        SET @RxNormCode = @evd_ext_vocab_id;
    END
    SET @RxNormCodeTypeId=-1
    IF (LEN(ISNULL(@RxNormCode,''))>0 AND @evd_ext_vocab_type_id IS NOT NULL)
	BEGIN

        IF @evd_ext_vocab_type_id='501'
        BEGIN
			SET @RxNormCodeTypeId=0;
            SET @RxNormCodeType = 'SCD';
		END
        ELSE IF @evd_ext_vocab_type_id='502'
        BEGIN
			SET @RxNormCodeTypeId=1;
			SET @RxNormCodeType = 'SBD'; 
        END   
		ELSE IF @evd_ext_vocab_type_id='503'
		BEGIN
			SET @RxNormCodeTypeId=3;
			SET @RxNormCodeType = 'GPK'; 
		END
        ELSE IF @evd_ext_vocab_type_id='504'
        BEGIN
			SET @RxNormCodeTypeId=2;
			SET @RxNormCodeType = 'BPK';
		END
    END
    INSERT INTO @Output (DrugId,RxNormCode,RxNormCodeTypeId,RxNormCodeType)  
	VALUES (@DrugId,@RxNormCode,@RxNormCodeTypeId,@RxNormCodeType)
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetRxNormCodeByNDC] 
( 
	@NDC VARCHAR(50)
) 
RETURNS @Output TABLE(NDC VARCHAR(50),NDCRxNormCode VARCHAR(50),NDCRxNormCodeTypeId INT,NDCRxNormCodeType VARCHAR(50))
BEGIN 
	DECLARE @NDCRxNormCode VARCHAR(50),@NDCRxNormCodeTypeId INT,@NDCRxNormCodeType VARCHAR(50)
	DECLARE @evd_ext_vocab_id VARCHAR(50),@evd_ext_vocab_type_id VARCHAR(50),@evd_vocab_type_desc VARCHAR(50),@evd_fdb_vocab_id VARCHAR(50)

	SELECT TOP 1  @evd_ext_vocab_type_id = evd_ext_vocab_type_id,@evd_vocab_type_desc = r2.evd_vocab_type_desc,@evd_ext_vocab_id=evd_ext_vocab_id,@evd_fdb_vocab_id =evd_fdb_vocab_id 
		FROM revdel0 r1 WITH(NOLOCK) 
		INNER JOIN revdvt0 r2 WITH(NOLOCK) ON r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id 
		WHERE evd_fdb_vocab_type_id=100  AND evd_fdb_vocab_id like @NDC
		AND EVD_LINK_TYPE_ID = 4
	     
    IF @evd_ext_vocab_id IS NOT NULL
    BEGIN
        SET @NDCRxNormCode = @evd_ext_vocab_id;
    END
    SET @NDCRxNormCodeTypeId=-1

    IF (LEN(ISNULL(@NDCRxNormCode,''))>0 AND @evd_ext_vocab_type_id IS NOT NULL)
	BEGIN

        IF @evd_ext_vocab_type_id='501'
        BEGIN
			SET @NDCRxNormCodeTypeId=0;
            SET @NDCRxNormCodeType = 'SCD';
		END
        ELSE IF @evd_ext_vocab_type_id='502'
        BEGIN
			SET @NDCRxNormCodeTypeId=1;
			SET @NDCRxNormCodeType = 'SBD'; 
        END   
		ELSE IF @evd_ext_vocab_type_id='503'
		BEGIN
			SET @NDCRxNormCodeTypeId=3;
			SET @NDCRxNormCodeType = 'GPK'; 
		END
        ELSE IF @evd_ext_vocab_type_id='504'
        BEGIN
			SET @NDCRxNormCodeTypeId=2;
			SET @NDCRxNormCodeType = 'BPK';
		END
    END
    INSERT INTO @Output (NDC,NDCRxNormCode,NDCRxNormCodeTypeId,NDCRxNormCodeType)  
	VALUES (@NDC,@NDCRxNormCode,@NDCRxNormCodeTypeId,@NDCRxNormCodeType)
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_MatchPatient] 
(  
	@RxNTPatientFirstName VARCHAR(50),
    @PatientFirstName VARCHAR(50),
    @RxNTPatientLastName VARCHAR(50),
    @PatientLastName VARCHAR(50),
    @RxNTPatientDOB DATETIME,
    @PatientDOB DATETIME
) 
	RETURNS BIT
BEGIN 
	DECLARE @IsSame BIT=1
	SET @RxNTPatientFirstName=LOWER(ISNULL(@RxNTPatientFirstName,''))
    SET @PatientFirstName=LOWER(ISNULL(@PatientFirstName,''))
    SET @RxNTPatientLastName = LOWER(ISNULL(@RxNTPatientLastName,''))
    SET @PatientLastName = LOWER(ISNULL(@PatientLastName,''))
	SET @RxNTPatientDOB = ISNULL(@RxNTPatientDOB,GETDATE()+100)
    SET @PatientDOB = ISNULL(@PatientDOB,GETDATE()+100)
	IF (@RxNTPatientFirstName!= @PatientFirstName)
	BEGIN
        SET @IsSame = 0; 
	END

    IF @RxNTPatientLastName != @PatientLastName
    BEGIN
        SET @IsSame = 0; 
	END

    IF CONVERT(VARCHAR(20),@RxNTPatientDOB,101) != CONVERT(VARCHAR(20),@PatientDOB,101) 
    BEGIN
        SET @IsSame = 0; 
	END
    RETURN  @IsSame
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[fnSplitEncounterIds] 
( 
    @encIds NVARCHAR(MAX), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(splitEncIds NVARCHAR(MAX) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @encIds) 
    WHILE @start < LEN(@encIds) + 1 BEGIN 
   
        IF @end = 0  
            SET @end = LEN(@encIds) + 1
       
        INSERT INTO @output (splitEncIds)  
        VALUES(SUBSTRING(@encIds, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @encIds, @start)
        
    END 
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[fnSplitString] 
( 
    @string NVARCHAR(MAX), 
    @delimiter CHAR(1),
    @pos int
) 
RETURNS NVARCHAR(MAX) 
BEGIN 
	DECLARE @output NVARCHAR(MAX)
	DECLARE @tTable TABLE(id INT , splitdata NVARCHAR(MAX))
    DECLARE @start INT, @end INT , @iRow INT
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    SET @iRow = 0
    WHILE @start < LEN(@string) + 1 BEGIN 
		SET @iRow = @iRow + 1
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @tTable (id,splitdata)  
        VALUES(@iRow,SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 
    select @output=splitdata from @tTable where id =  @pos
    RETURN @output;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
	CREATE FUNCTION dbo.fn_diagramobjects() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
        
      
      
CREATE FUNCTION [dbo].[GetDoctorCompanyApplicationVersion]       
(  
	@dc_id AS BIGINT,   -- Doctor Company Id
	@applicationtypename AS VARCHAR(100) -- Application type name
)      
RETURNS INT      

AS      
BEGIN      
	DECLARE @applicationversionid AS INT  
	
	IF EXISTS(SELECT 1 FROM applications app 
	INNER JOIN doc_group_application_map dg_app ON app.applicationid=dg_app.applicationid
	INNER JOIN doc_groups dg ON dg.dg_id = dg_app.dg_id
	INNER JOIN applicationtypes at ON app.applicationtypeid=at.applicationtypeid
	WHERE dg.dc_id=@dc_id AND at.applicationtypename = @applicationtypename )
	BEGIN
		-- If the Doctor Group has the application mapping
		SELECT TOP 1  @applicationversionid = app.applicationversionid
		FROM applications app 
		INNER JOIN doc_group_application_map dg_app ON app.applicationid=dg_app.applicationid
		INNER JOIN doc_groups dg ON dg.dg_id = dg_app.dg_id
		INNER JOIN applicationtypes at ON app.applicationtypeid=at.applicationtypeid
		WHERE dg.dc_id=@dc_id AND at.applicationtypename = @applicationtypename AND app.active=1
		ORDER BY app.applicationid DESC
	END
	ELSE
	BEGIN
		-- If the Doctor Group has not the application mapping it will select the default
		SELECT  TOP 1 @applicationversionid = app.applicationversionid
		FROM applications app
		INNER JOIN applicationtypes at ON app.applicationtypeid=at.applicationtypeid
		WHERE at.applicationtypename = @applicationtypename AND app.active=1 AND app.isdefault=1
		ORDER BY app.applicationid DESC
	END
	
	RETURN @applicationversionid      
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[getUTCDateTime] 
( 
    @dt DATETIME      
) 
RETURNS DATETIME 
AS 
BEGIN 
    SELECT TOP 1 @dt = DATEADD(HOUR, UTCOffset, @dt) 
        FROM Calendar WITH (NOLOCK) 
        WHERE dt <= @dt 
        ORDER BY dt DESC 
 
    RETURN @dt 
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  


CREATE FUNCTION GET_TZTIME 
	(@DT AS DATETIME, 
	 @TZ AS VARCHAR(12))
RETURNS DATETIME
AS
BEGIN
-- DECLARE VARIABLES
	DECLARE @NEWDT AS DATETIME
	DECLARE @OFFSETHR AS INT
	DECLARE @OFFSETMI AS INT
	DECLARE @DSTOFFSETHR AS INT
	DECLARE @DSTOFFSETMI AS INT
	DECLARE @DSTDT AS VARCHAR(10)
	DECLARE @DSTEFFDT AS VARCHAR(10)
	DECLARE @DSTENDDT AS VARCHAR(10)
	
-- GET THE DST parameter from the provided datetime
	-- This gets the month of the datetime provided (2 char value)
	SELECT @DSTDT = CASE LEN(DATEPART(month, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(month, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(month, @DT)) END
	-- This gets the occurance of the day of the week within the month (i.e. first sunday, or second sunday...) (1 char value)
	SELECT @DSTDT = @DSTDT + CONVERT(VARCHAR(1),(DATEPART(day,@DT) + 6) / 7)
	-- This gets the day of the week for the provided datetime (1 char value)
	SELECT @DSTDT = @DSTDT + CONVERT(VARCHAR(1),DATEPART(dw, @DT))
	-- This gets the hour for the provided datetime (2 char value)
	SELECT @DSTDT = @DSTDT + CASE LEN(DATEPART(hh, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(hh, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(hh, @DT)) END
	-- This gets the minutes for the provided datetime (2 char value)
	SELECT @DSTDT = @DSTDT + CASE LEN(DATEPART(mi, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(mi, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(mi, @DT)) END
	
	-- This query gets the timezone information from the TIME_ZONES table for the provided timezone
	SELECT
		@OFFSETHR=offset_hr,
		@OFFSETMI=offset_mi,
		@DSTOFFSETHR=dst_offset_hr,
		@DSTOFFSETMI=dst_offset_mi,
		@DSTEFFDT=dst_eff_dt,
		@DSTENDDT=dst_END_dt
	FROM time_zones
	WHERE timezone_cd = @TZ AND
		@DT BETWEEN eff_dt AND end_dt
	
	-- Checks to see if the DST parameter for the datetime provided is within the DST parameter for the timezone
	IF @DSTDT BETWEEN @DSTEFFDT AND @DSTENDDT
	BEGIN
		-- Increase the datetime by the hours and minutes assigned to the timezone
		SET @NEWDT = DATEADD(hh,@DSTOFFSETHR,@DT)
		SET @NEWDT = DATEADD(mi,@DSTOFFSETMI,@NEWDT)
	END
	-- If the DST parameter for the provided datetime is not within the defined
	-- DST eff and end dates for the timezone then use the standard time offset
	ELSE
	BEGIN
		-- Increase the datetime by the hours and minutes assigned to the timezone
		SET @NEWDT = DATEADD(hh,@OFFSETHR,@DT)
		SET @NEWDT = DATEADD(mi,@OFFSETMI,@NEWDT)
	END

	-- Return the new date that has been converted from UTC time
	RETURN @NEWDT
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION GET_UTCTIME 
	(@DT AS DATETIME, 
	 @TZ AS VARCHAR(12))
RETURNS DATETIME
AS
BEGIN
-- DECLARE VARIABLES
	DECLARE @NEWDT AS DATETIME
	DECLARE @OFFSETHR AS INT
	DECLARE @OFFSETMI AS INT
	DECLARE @DSTOFFSETHR AS INT
	DECLARE @DSTOFFSETMI AS INT
	DECLARE @DSTDT AS VARCHAR(10)
	DECLARE @DSTEFFDT AS VARCHAR(10)
	DECLARE @DSTENDDT AS VARCHAR(10)
	
-- GET THE DST parameter from the provided datetime
	-- This gets the month of the datetime provided (2 char value)
	SELECT @DSTDT = CASE LEN(DATEPART(month, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(month, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(month, @DT)) END
	-- This gets the occurance of the day of the week within the month (i.e. first sunday, or second sunday...) (1 char value)
	SELECT @DSTDT = @DSTDT + CONVERT(VARCHAR(1),(DATEPART(day,@DT) + 6) / 7)
	-- This gets the day of the week for the provided datetime (1 char value)
	SELECT @DSTDT = @DSTDT + CONVERT(VARCHAR(1),DATEPART(dw, @DT))
	-- This gets the hour for the provided datetime (2 char value)
	SELECT @DSTDT = @DSTDT + CASE LEN(DATEPART(hh, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(hh, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(hh, @DT)) END
	-- This gets the minutes for the provided datetime (2 char value)
	SELECT @DSTDT = @DSTDT + CASE LEN(DATEPART(mi, @DT)) WHEN 1 then '0' + CONVERT(VARCHAR(2),DATEPART(mi, @DT)) ELSE CONVERT(VARCHAR(2),DATEPART(mi, @DT)) END
	
	-- This query gets the timezone information from the TIME_ZONES table for the provided timezone
	SELECT
		@OFFSETHR=offset_hr,
		@OFFSETMI=offset_mi,
		@DSTOFFSETHR=dst_offset_hr,
		@DSTOFFSETMI=dst_offset_mi,
		@DSTEFFDT=dst_eff_dt,
		@DSTENDDT=dst_END_dt
	FROM time_zones
	WHERE timezone_cd = @TZ AND
		@DT BETWEEN eff_dt AND end_dt
	
	-- Checks to see if the DST parameter for the datetime provided is within the DST parameter for the timezone
	IF @DSTDT BETWEEN @DSTEFFDT AND @DSTENDDT
	BEGIN
		-- Increase the datetime by the hours and minutes assigned to the timezone
		SET @NEWDT = DATEADD(hh,ABS(@DSTOFFSETHR),@DT)
		SET @NEWDT = DATEADD(mi,ABS(@DSTOFFSETMI),@NEWDT)
	END
	-- If the DST parameter for the provided datetime is not within the defined
	-- DST eff and end dates for the timezone then use the standard time offset
	ELSE
	BEGIN
		-- Increase the datetime by the hours and minutes assigned to the timezone
		SET @NEWDT = DATEADD(hh,ABS(@OFFSETHR),@DT)
		SET @NEWDT = DATEADD(mi,ABS(@OFFSETMI),@NEWDT)
	END

	-- Return the new date that has been converted to UTC time
	RETURN @NEWDT
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[IS_CLIENT_PREF_TIME] 
	(@DT AS DATETIME, 
	 @TZ AS VARCHAR(12),
	 @prefstarttime AS DATETIME,
	 @prefendtime AS DATETIME)
RETURNS BIT
AS
BEGIN
	DECLARE @RESULT AS BIT
	DECLARE @NEWDT AS DATETIME
	DECLARE @TODAY AS DATETIME
	SET @NEWDT=dbo.GET_TZTIME(@DT,@TZ)
	SET @TODAY=DATEADD(dd, DATEDIFF(d, 0, @DT), 0)
	IF @NEWDT >= @TODAY+@prefstarttime AND @NEWDT<= @TODAY+@prefendtime  
		SET @RESULT= 1
	ELSE
		SET @RESULT= 0
	RETURN  @RESULT 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION NEW_TIME 
	(@DT AS DATETIME, 
	 @TZ1 AS VARCHAR(12),
	 @TZ2 AS VARCHAR(12))
RETURNS DATETIME
AS
BEGIN
	-- Declare variables
	DECLARE @NEWDT AS DATETIME
	
	-- Check to see if the provided timezone for the source datetime is in GMT or UTC time
	-- If it is not then convert the provided datetime to UTC time
	IF NOT @TZ1 IN ('GMT','UTC')
	BEGIN
		SELECT @NEWDT = dbo.GET_UTCTIME(@DT,@TZ1)
	END
	ELSE
	-- If the provided datetime is in UTC or GMT time then set the NEWTIME variable to this value
	BEGIN
		SET @NEWDT = @DT
	END

	-- Check to see if the provided conversion timezone is GMT or UTC
	-- If it is then no conversion is needed.
	-- If it is not then convert the provided datetime to the desired timezone
	IF NOT @TZ2 IN ('GMT','UTC')
	BEGIN
		SELECT @NEWDT = dbo.GET_TZTIME(@NEWDT,@TZ2)
	END

	-- Return the new converted datetime
	RETURN @NEWDT
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[ProperCase](@Text as varchar(8000))
returns varchar(8000)
as
begin
  declare @Reset bit;
  declare @Ret varchar(8000);
  declare @i int;
  declare @c char(1);

  if @Text is null
    return null;

  select @Reset = 1, @i = 1, @Ret = '';

  while (@i <= len(@Text))
    select @c = substring(@Text, @i, 1),
      @Ret = @Ret + case when @Reset = 1 then UPPER(@c) else @c end,
      @Reset = case when @c like '[a-zA-Z]' then 0 else 1 end,
      @i = @i + 1
  return @Ret
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Function [dbo].[RemoveNonIntegers] (@ConvertedInteger VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @KeepValues as varchar(50)
    Set @KeepValues = '%[^0-9]%'
    While PatIndex(@KeepValues, @ConvertedInteger) > 0
        Set @ConvertedInteger = Stuff(@ConvertedInteger, PatIndex(@KeepValues, @ConvertedInteger), 1, '')

    Return @ConvertedInteger
End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION SplitString
(    
      @Input NVARCHAR(MAX),
      @Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
      BEGIN
            SET @Input = @Input + @Character
      END
 
      WHILE CHARINDEX(@Character, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Character, @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[StripHTMLFromString] (@HTMLText VARCHAR(MAX))
RETURNS VARCHAR(MAX) AS
BEGIN
    DECLARE @Start INT
    DECLARE @End INT
    DECLARE @Length INT
    SET @Start = CHARINDEX('<',@HTMLText)
    SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
    SET @Length = (@End - @Start) + 1
    WHILE @Start > 0 AND @End > 0 AND @Length > 0
    BEGIN
        SET @HTMLText = STUFF(@HTMLText,@Start,@Length,'')
        SET @Start = CHARINDEX('<',@HTMLText)
        SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
        SET @Length = (@End - @Start) + 1
    END
    RETURN LTRIM(RTRIM(@HTMLText))
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_GetNDCByDrugId] 
( 
    @DrugId BIGINT
) 
RETURNS VARCHAR(50)
BEGIN 
	DECLARE @NDC VARCHAR(50) 
	SELECT TOP 1  @NDC=a.NDC
	FROM rnmmidndc a WITH(NOLOCK)
	WHERE a.MEDID=@DrugId AND a.OBSDTEC IS NULL
    RETURN  @NDC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
====================================================================================================
Author				:	SHEIK
Create date			:	28-Jan-2020
Description			:	This procedure is used to parse csv to temp table
Last Modified By	:
Last Modifed Date	:
====================================================================================================
*/
CREATE FUNCTION [dbo].[ufp_ParseCSVToTable](@origString varchar(max), @Delimiter char(1))     
returns @temptable TABLE (items varchar(max))     
as     
begin     
    declare @idx int     
    declare @split varchar(max)     

    select @idx = 1     
        if len(@origString )<1 or @origString is null  return     

    while @idx!= 0     
    begin     
        set @idx = charindex(@Delimiter,@origString)     
        if @idx!=0     
            set @split= left(@origString,@idx - 1)     
        else     
            set @split= @origString

        if(len(@split)>0)
            insert into @temptable(Items) values(@split)     

        set @origString= right(@origString,len(@origString) - @idx)     
        if len(@origString) = 0 break     
    end 
return     
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[UTCConvert] 
(

    @p1 datetime
)
RETURNS datetime
AS
BEGIN
	DECLARE @UTCDate datetime
	DECLARE @LocalDate datetime
	DECLARE @TimeDiff int

	-- Figure out the time difference between UTC and Local time
	SET @UTCDate = GETUTCDATE()
	SET @LocalDate = GETDATE()
	SET @TimeDiff = DATEDIFF(hh, @UTCDate, @LocalDate)


	-- Convert UTC to local time
	DECLARE @DateYouWantToConvert datetime
	DECLARE @ConvertedLocalTime datetime

	SET @DateYouWantToConvert = @p1
	SET @ConvertedLocalTime = DATEADD(hh, @TimeDiff, @DateYouWantToConvert)

	-- Check Results
	RETURN @ConvertedLocalTime
End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
