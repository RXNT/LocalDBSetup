SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   PROCEDURE [eRx2019].[usp_SaveRxChangeRequest] 
@ChgType BIGINT,
@MessgaeId VARCHAR(50),
@SenderPharmacyNCPDPNumber VARCHAR(15),
@DoctorSPI VARCHAR(50),
@PrescriberOrderNumber BIGINT,
@DoctorObjectText VARCHAR(MAX),
@AgentInfo VARCHAR(MAX),
@SupervisorObjectText VARCHAR(MAX),
@SupervisorInfo VARCHAR(MAX),
@SupervisorNPI VARCHAR(20),
@PharmacyNCPDPNumber VARCHAR(15),
@PatientFirstName VARCHAR(50)=NULL,
@PatientMiddleName VARCHAR(50)=NULL,
@PatientLastName VARCHAR(50)=NULL,
@PatientDOB DATETIME,
@PatientGender VARCHAR(1)=NULL,
@PatientAddressLine1 VARCHAR(100)=NULL,
@PatientAddressLine2 VARCHAR(100)=NULL,
@PatientCity VARCHAR(100)=NULL,
@PatientState VARCHAR(50)=NULL,
@PatientZipCode VARCHAR(50)=NULL,
@PatientPhone VARCHAR(50)=NULL,
@PatientHeight VARCHAR(50)=NULL,
@PatientWeight VARCHAR(50)=NULL,
@NDC VARCHAR(50),
@DrugName VARCHAR(255),
@RxNTDrugCategory INT,

@refreq_date DATETIME,
--@trc_number VARCHAR(100),
--@ctrl_number VARCHAR(100), 
@recverVector VARCHAR(50), 
@senderVector VARCHAR(50),
@init_date DATETIME,
@msg_date DATETIME, 
@msg_ref_number VARCHAR(35),
@PharmSeg VARCHAR(MAX),
@PatientSeg VARCHAR(MAX),
@PrescDRUSeg VARCHAR(MAX),
@fullRequestMessage XML,
@versionType VARCHAR(5),
@has_miss_match BIT=NULL,
@miss_match_reson VARCHAR(1)=NULL,

@p_drug_name VARCHAR(125),
@p_drug_ndc VARCHAR(11),
@p_drug_form_code VARCHAR(15),
@p_drug_form_source_code VARCHAR(3),
@p_drug_strength VARCHAR(70),
@p_drug_strength_code VARCHAR(15),
@p_drug_strength_source_code VARCHAR(3),
@p_qty1 VARCHAR(35),
@p_qty2 VARCHAR(35),
@p_qty1_unit_code VARCHAR(50),
@p_qty2_units VARCHAR(50),
@p_qty1_enum TINYINT,
@p_qty2_enum TINYINT,
@p_dosage1 VARCHAR(1000),
@p_days_supply INT,
@p_date1 SMALLDATETIME,
@p_date2 SMALLDATETIME,
@p_date3 SMALLDATETIME,
@p_date1_enum TINYINT,
@p_date2_enum TINYINT,
@p_date3_enum TINYINT,
@p_substitution_code TINYINT, 
@p_refills VARCHAR(35),
@p_refills_enum TINYINT,
@p_comments1 VARCHAR(210),
@p_disp_drug_info BIT,
@p_doc_info_text VARCHAR(MAX),

@HasRequestedDrug BIT,
@RxNTRxType INT,
@RxSrc INT,
--@Message VARCHAR(2000) OUTPUT
@Dosage VARCHAR(255),
@IsUseGeneric BIT,
@NoOfRefills INT,
@Comments VARCHAR(255),
@DurationAmount VARCHAR(15),
@DurationUnitCode VARCHAR(10),
@DaysSupply SMALLINT,
@IsRefillsPrn BIT,
@NoOfMedicationsRequested INT,
@ChangeReason VARCHAR(500),
@DiagnosisCode VARCHAR(10)=NULL,
@DiagnosisDescription VARCHAR(255)=NULL,
@p_diagnosis_code VARCHAR(10)=NULL,
@p_diagnosis_description VARCHAR(255)=NULL
               
AS
BEGIN 
	DECLARE @DurationUnit VARCHAR(255),@ScriptGuideId INT,@ScriptGuideStatus TINYINT
	IF @NoOfRefills IS NULL
	BEGIN
		SET @NoOfRefills=0
	END
	SET @DurationUnit=[eRx2019].[ufn_GetPotencyUnitByCode](@DurationUnitCode)
	DECLARE @p_qty1_units VARCHAR(50)=''
	SET @p_qty1_units=[eRx2019].[ufn_GetPotencyUnitByCode](@p_qty1_unit_code)
	DECLARE @Message TABLE (Message VARCHAR(MAX))
	DECLARE @DoctorGroupId INT,@DoctorCompanyId INT,@DoctorId INT, @AuthorizingDoctorId INT, @IsEPCSEnabled BIT,@PatientId INT,@PharmacyId INT,@RxDetailId INT
	,@DrugId BIGINT,@DrugLevel INT
    

    SELECT *
    INTO #PrescriberInfo
    FROM [eRx2019].[ufn_GetPrescriberInfoBySPI](@DoctorSPI)
    IF @@ROWCOUNT !=1
    BEGIN
		INSERT INTO @Message VALUES('Active Prescriber Couldn''t be Found')
		SELECT * FROM @Message
		RETURN
    END
    
    SELECT  TOP 1 @DoctorId = DoctorId,@DoctorGroupId = DoctorGroupId, @DoctorCompanyId= DoctorCompanyId, @IsEPCSEnabled = IsEPCSEnabled
    FROM #PrescriberInfo
    
    SELECT  TOP 1 @PatientId=PatientId,@DrugId = DrugId,@DrugLevel = DrugLevel,@IsEPCSEnabled = IsEPCSEnabled,@RxDetailId = RxDetailId
    FROM [eRx2019].[ufn_GetRxInfoByRxId](@PrescriberOrderNumber,@DoctorCompanyId)
	IF @HasRequestedDrug=1
	BEGIN
		SET @DrugId = NULL
		SET @DrugLevel = NULL
	END
	
	IF LEN(@SupervisorNPI)>0
	BEGIN
		SELECT TOP 1 @AuthorizingDoctorId = DoctorId
		FROM [eRx2019].[ufn_GetPrescriberInfoByNPI](@SupervisorNPI)
		WHERE DoctorCompanyId=@DoctorCompanyId
	END
	IF LEN(@PharmacyNCPDPNumber)>0
	BEGIN
		SELECT  TOP 1 @PharmacyId=PharmacyId
		FROM [eRx2019].[ufn_GetPharmacyInfoByNCPDPNumber](@PharmacyNCPDPNumber)
	END
	
	IF ISNULL(@PharmacyId,0)<=0
	BEGIN
		SELECT  TOP 1 @PharmacyId=PharmacyId
		FROM [eRx2019].[ufn_GetPharmacyInfoByNCPDPNumber](@SenderPharmacyNCPDPNumber)
    END
    
    IF ISNULL(@PharmacyId,0)<=0
	BEGIN 
		INSERT INTO @Message VALUES('Pharmacy Couldn''t be Found')
		SELECT * FROM @Message
		RETURN
	END
	DECLARE @RefillRequestMissMatches VARCHAR(100)=''
	DECLARE @PatientFound BIT = 0,@RxNTPatientPatientId BIGINT,@RxNTPatientLastName VARCHAR(50),@RxNTPatientFirstName VARCHAR(50),@RxNTPatientMiddleName VARCHAR(50),@RxNTPatientGender VARCHAR(1),@RxNTPatientDOB DATETIME
	IF @PatientId>0
	BEGIN
		SELECT @RxNTPatientLastName=LastName,@RxNTPatientFirstName=FirstName,@RxNTPatientMiddleName=MiddleName,@RxNTPatientGender=Gender,@RxNTPatientDOB=DOB
		FROM [eRx2019].[ufn_GetPatientInfoById](@PatientId)
		SET @PatientFound = 1;
	END
	ELSE
	BEGIN
		SELECT *
		INTO #PatientInfo
		FROM [eRx2019].[ufn_GetPatientInfoByDetails](@DoctorCompanyId,@PatientFirstName,@PatientLastName,@PatientDOB)
		IF (SELECT COUNT(1) FROM #PatientInfo)>1
		BEGIN
			SET @RefillRequestMissMatches=@RefillRequestMissMatches+'<div><label>Pharmacy demographics mismatch found. </label> </div>'
		END
		
		SELECT TOP 1 @RxNTPatientLastName=LastName,@RxNTPatientFirstName=FirstName,@RxNTPatientMiddleName=MiddleName,@RxNTPatientGender=Gender,@RxNTPatientDOB=DOB
		FROM #PatientInfo
		
		DROP TABLE #PatientInfo
	END
	
	IF [eRx2019].[ufn_MatchPatient](@RxNTPatientFirstName,@PatientFirstName,@RxNTPatientLastName,@PatientLastName,@RxNTPatientDOB,@PatientDOB)=0
	BEGIN
		SET @RefillRequestMissMatches=@RefillRequestMissMatches+ '<div><label>Pharmacy demographics mismatch found.</label> </div>' + [eRx2019].[ufn_GetPatientMismatchInfoHtml](@RxNTPatientFirstName,@PatientFirstName,@RxNTPatientLastName,@PatientLastName,@RxNTPatientDOB,@PatientDOB, @PatientMiddleName,@PatientGender,@PatientAddressLine1,@PatientAddressLine2,@PatientCity,@PatientState,@PatientZipCode,@PatientPhone);
		IF @PatientFound=0
		BEGIN
			EXEC @PatientId = [eRx2019].usp_SavePatient @DoctorGroupId=@DoctorGroupId,@DoctorId=@DoctorId,@PatientFirstName=@PatientFirstName,@PatientMiddleName=@PatientMiddleName,@PatientLastName=@PatientLastName,@PatientDOB=@PatientDOB,@PatientGender=@PatientGender,@PatientAddressLine1=@PatientAddressLine1,@PatientAddressLine2=@PatientAddressLine2,@PatientCity=@PatientCity,@PatientState=@PatientState,@PatientZipCode=@PatientZipCode,@PatientPhone=@PatientPhone,@CreatedBySystem='TRANCEIVER_REFILL_REQUEST'
		END
	END
	
	IF ISNULL(@PatientId,0)<=0
	BEGIN 
		INSERT INTO @Message VALUES('Invalid Patient')
		SELECT * FROM @Message
		RETURN
	END
	 
	IF LEN(@NDC)>0
	BEGIN
		 SELECT @DrugId=DrugId,@DrugName = DrugName,@DrugLevel=DrugLevel  FROM [eRx2019].[ufn_GetDrugDetailsByNDC](@NDC)
	END
	
	
	IF ISNULL(@DrugId,0)=0
	BEGIN
		 SELECT @DrugId=DrugId,@DrugName = DrugName,@DrugLevel=DrugLevel  FROM [eRx2019].[ufn_GetDrugDetailsByName](@DrugName)
	END  
	
	IF ISNULL(@DrugId,0)=0 AND @RxNTDrugCategory IN (1,2)-- 1 : Compound Drug, 2: Supplies
	BEGIN
		EXECUTE @DrugId = addDocGroupFreeTextMeds @added_by_dr_id=@DoctorId,@dg_id=@DoctorGroupId,@drug_name=@DrugName,@drug_level=@DrugLevel,@drug_category=@RxNTDrugCategory
		IF(@DrugId < 0)
			SET @DrugId = 0;
	END
 
	
    DECLARE @RxId BIGINT
    DECLARE @RxEntryDate DATETIME=GETDATE()
	SET  @DiagnosisCode = ISNULL(@DiagnosisCode,'')
	DECLARE @RxDiagnosisCode VARCHAR(10)=NULL
	DECLARE @RxDiagnosisDescription VARCHAR(255)=NULL
	SET @RxDiagnosisCode=ISNULL(@p_diagnosis_code,'')
	SET @RxDiagnosisDescription=@p_diagnosis_description
	IF LEN(@RxDiagnosisCode)<=0 AND LEN( ISNULL(@DiagnosisCode,''))>0
	BEGIN
		SET @RxDiagnosisCode = ISNULL(@DiagnosisCode,'')
		SET @RxDiagnosisDescription = @DiagnosisDescription
	END
	EXECUTE @RxId = [eRx2019].[usp_SavePatientRx] @RxId=NULL,@PatientId = @PatientId,@DoctorId = @DoctorId,@DoctorGroupId = @DoctorGroupId, @PharmacyId = @PharmacyId,@PrimaryDoctorId = @DoctorId, @DeliveryMethod = 262144,@IsSigned = 0, @PrintingOptions = 0,@IsVoid = 0,@RxNTRxType = @RxNTRxType,@RxEntryDate = @RxEntryDate,@RxApprovedDate=NULL,@IsEligibilityChecked = 0,@EligibilityTransactionId=NULL,@Src = @RxSrc,@StartDate = NULL,@EndDate = NULL,@VoidComments = '',@VoidCode = NULL,@AuthorizingDoctorId =@AuthorizingDoctorId
	,@DrugName=@DrugName,@DrugId =@DrugId,@Dosage =@Dosage,@MaxDailyDosage =NULL,@IsUseGeneric=@IsUseGeneric,@NoOfRefills=@NoOfRefills,@Comments =@Comments,@DurationAmount =@DurationAmount,@DurationUnit =@DurationUnit,@IsPrn =0,@IsAsDirected =0,@DoIncludeInPrint =0,@DoIncludeInPharmDelivery =0,@PrnDescription ='',@IsCompound =0,@DiagnosisCode = @RxDiagnosisCode,@DaysSupply=@DaysSupply,@IsRefillsPrn=@IsRefillsPrn,@AgentInfo =@AgentInfo,@SupervisorInfo =@SupervisorInfo,@OrderReason =@ChangeReason,@DiagnosisCodeDescription =@RxDiagnosisDescription,@Pain =NULL,@ScriptGuideId =@ScriptGuideId,@ScriptGuideStatus =@ScriptGuideStatus,@PatientHeight=@PatientHeight,@PatientWeight=@PatientWeight
	
	DECLARE @ChangeRequestId AS INT 
    INSERT INTO [erx].[RxChangeRequests]  (DoctorGroupId, DoctorId, PatientId, pharm_id, pharm_ncpdp, PresId, ChgType, RequestDate, PrescriberOrderNumber, MessageId, recverVector, senderVector, InitDate, MsgDate, msg_ref_number,PharmSeg,PatientSeg,SupervisorSeg,DoctorSeg,PrescDrug,FullReqMessage,versionType,HasMissMatch,MissMatchReason,DeliveryMethod,NoOfMedicationsRequested) 
    VALUES (@DoctorGroupId, @DoctorId, @PatientId, @PharmacyId, @PharmacyNCPDPNumber, @RxId, @ChgType, @refreq_date, @PrescriberOrderNumber, @MessgaeId, @recverVector, @senderVector, @init_date,@msg_date, @msg_ref_number,@PharmSeg,@PatientSeg,@SupervisorObjectText,@DoctorObjectText,@PrescDRUSeg,@fullRequestMessage,@versionType,@has_miss_match,@miss_match_reson,262144,@NoOfMedicationsRequested); 
  
    SET @ChangeRequestId =SCOPE_IDENTITY()
                
    --Save Prescribed Drug Info
    UPDATE [erx].[RxChangeRequests]  SET DrugName=@p_drug_name,DrugNDC=@p_drug_ndc,DrugFormCode=@p_drug_form_code,DrugFormSourceCode=@p_drug_form_source_code,DrugStrength=@p_drug_strength,DrugStrengthCode=@p_drug_strength_code,DrugStrengthSourceCode=@p_drug_strength_source_code,qty1=@p_qty1,qty2=@p_qty2,Qty1Units=@p_qty1_units,Qty2Units=@p_qty2_units,Qty1Enum=@p_qty1_enum,Qty2Enum=@p_qty2_enum 
	 ,dosage1=@p_dosage1,DaysSupply=@p_days_supply,date1=@p_date1,date2=@p_date2,date3=@p_date3,Date1Enum=@p_date1_enum,Date2Enum=@p_date2_enum,Date3Enum=@p_date3_enum,SubstitutionCode=@p_substitution_code, 
	 refills=@p_refills,RefillsType=@p_refills_enum,comments1=@p_comments1,DispDrugInfo=@p_disp_drug_info,DocInfoText=@p_doc_info_text WHERE ChgReqId = @ChangeRequestId
	 
	SELECT @ChangeRequestId AS ChangeRequestId 
            
END


                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
