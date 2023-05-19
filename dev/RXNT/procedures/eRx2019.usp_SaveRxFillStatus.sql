SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SaveRxFillStatus] 
@MessgaeId VARCHAR(50),
@SenderPharmacyNCPDPNumber VARCHAR(15),
@DoctorSPI VARCHAR(20),
@PrescriberOrderNumber BIGINT,
@AgentInfo VARCHAR(5000),
@SupervisorInfo VARCHAR(5000),
@SupervisorNPI VARCHAR(20),
@PharmacyNCPDPNumber VARCHAR(15),
@PatientFirstName VARCHAR(50),
@PatientMiddleName VARCHAR(50),
@PatientLastName VARCHAR(50),
@PatientDOB DATETIME,
@PatientGender VARCHAR(1),
@PatientAddressLine1 VARCHAR(100),
@PatientAddressLine2 VARCHAR(100)=NULL,
@PatientCity VARCHAR(100),
@PatientState VARCHAR(50),
@PatientZipCode VARCHAR(50),
@PatientPhone VARCHAR(50),
@NDC VARCHAR(50),
@DrugName VARCHAR(50),
@RxNTDrugCategory INT,
@refreq_date DATETIME,
@init_date DATETIME,
@msg_date DATETIME, 
@fullRequestMessage XML,
@has_miss_match BIT,
@miss_match_reson VARCHAR(1),
@p_drug_name VARCHAR(125),
@p_drug_ndc VARCHAR(11),
@p_drug_form_code VARCHAR(15),
@p_drug_form_source_code VARCHAR(3),
@p_drug_strength VARCHAR(70),
@p_drug_strength_code VARCHAR(15),
@p_drug_strength_source_code VARCHAR(3),
@p_qty1 VARCHAR(35),
@p_qty2 VARCHAR(35),
@p_qty1_units VARCHAR(50),
@p_qty2_units VARCHAR(50),
@p_qty1_enum TINYINT,
@p_qty2_enum TINYINT,
@p_dosage1 VARCHAR(140),
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
@p_doc_info_text VARCHAR(5000),
@HasDispensedDrug BIT,
@d_drug_name VARCHAR(125),
@d_drug_ndc VARCHAR(11),
@d_drug_form_code VARCHAR(15),
@d_drug_form_source_code VARCHAR(3),
@d_drug_strength VARCHAR(70),
@d_drug_strength_code VARCHAR(15),
@d_drug_strength_source_code VARCHAR(3),
@d_qty1 VARCHAR(35),
@d_qty2 VARCHAR(35),
@d_qty1_units VARCHAR(50),
@d_qty2_units VARCHAR(50),
@d_qty1_enum TINYINT,
@d_qty2_enum TINYINT,
@d_dosage1 VARCHAR(140),
@d_days_supply INT,
@d_date1 SMALLDATETIME,
@d_date2 SMALLDATETIME,
@d_date3 SMALLDATETIME,
@d_date1_enum TINYINT,
@d_date2_enum TINYINT,
@d_date3_enum TINYINT,
@d_substitution_code TINYINT, 
@d_refills VARCHAR(35),
@d_refills_enum TINYINT,
@d_comments1 VARCHAR(210),
@d_doc_info_text VARCHAR(5000),
@RxNTRxType INT,
@RxSrc INT,
@Dosage VARCHAR(255),
@IsUseGeneric BIT,
@NoOfRefills INT,
@Comments VARCHAR(255),
@DurationAmount VARCHAR(15),
@DurationUnitCode VARCHAR(10),
@DaysSupply SMALLINT,
@IsRefillsPrn BIT,
@ResponseType INT = NULL,
@Reason VARCHAR(150) = NULL,
@Note VARCHAR(MAX) = NULL
AS
BEGIN 
	DECLARE @DurationUnit VARCHAR(255),@ScriptGuideId INT,@ScriptGuideStatus TINYINT
	
	SET @DurationUnit=[eRx2019].[ufn_GetPotencyUnitByCode](@DurationUnitCode)
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
    DECLARE @RxId BIGINT=@PrescriberOrderNumber
    SELECT  TOP 1 @PatientId=PatientId,@DrugId = DrugId,@DrugLevel = DrugLevel,@IsEPCSEnabled = IsEPCSEnabled,@RxDetailId = RxDetailId
    FROM [eRx2019].[ufn_GetRxInfoByRxId](@PrescriberOrderNumber,@DoctorCompanyId)

	IF NOT(ISNULL(@RxId,0)>0 AND ISNULL(@RxDetailId,0)>0)
	BEGIN
		INSERT INTO @Message VALUES('Presription Couldn''t be Found')
		SELECT * FROM @Message
		RETURN
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
			INSERT INTO @Message VALUES('Patient bot found')
			SELECT * FROM @Message
			RETURN
		END
	END
	
	IF ISNULL(@PatientId,0)<=0
	BEGIN 
		INSERT INTO @Message VALUES('Invalid Patient')
		SELECT * FROM @Message
		RETURN
	END
	  
	
 
	DECLARE @refillRequestId AS INT 
    INSERT INTO [erx].[RxFillRequests] (DoctorGroupId, DoctorId, PatientId, PharmId, PresId, RequestDate, PrescriberOrderNumber, MessageId, InitDate, MsgDate,HasMissMatch,MissMatchReason,ResponseType,Reason, Note) 
    VALUES (@DoctorGroupId, @DoctorId, @PatientId, @PharmacyId,  @RxId, @refreq_date, @PrescriberOrderNumber, @MessgaeId, @init_date,@msg_date,@has_miss_match,@miss_match_reson,@ResponseType,@Reason, @Note); 
  
    SET @refillRequestId =SCOPE_IDENTITY()
                
    --Save Prescribed Drug Info
    UPDATE [erx].[RxFillRequests] SET DrugName=@p_drug_name,DrugNDC=@p_drug_ndc,DrugFormCode=@p_drug_form_code,DrugFormSourceCode=@p_drug_form_source_code,DrugStrength=@p_drug_strength,DrugStrengthCode=@p_drug_strength_code,DrugStrengthSourceCode=@p_drug_strength_source_code,qty1=@p_qty1,qty2=@p_qty2,Qty1Units=@p_qty1_units,Qty2Units=@p_qty2_units,Qty1Enum=@p_qty1_enum,Qty2Enum=@p_qty2_enum 
	,dosage1=@p_dosage1,DaysSupply=@p_days_supply,date1=@p_date1,date2=@p_date2,date3=@p_date3,Date1Enum=@p_date1_enum,Date2Enum=@p_date2_enum,Date3Enum=@p_date3_enum,SubstitutionCode=@p_substitution_code, 
	Refills=@p_refills,RefillsType=@p_refills_enum,comments1=@p_comments1,DispDrugInfo=@p_disp_drug_info,DocInfoText=@p_doc_info_text WHERE FillReqId = @refillRequestId
	 
	
	INSERT INTO [erx].[RxFillRequestsInfo] (FillReqId, type,FullReqMessage) VALUES (@refillRequestId,'D',@fullRequestMessage)
	--Save Dispensed Drug Info
	IF @HasDispensedDrug = 1
	BEGIN
		UPDATE [erx].[RxFillRequestsInfo] 
		SET DrugName=@d_drug_name,DrugNDC=@d_drug_ndc,DrugFormCode=@d_drug_form_code,DrugFormSourceCode=@d_drug_form_source_code,DrugStrength=@d_drug_strength,DrugStrengthCode=@d_drug_strength_code,DrugStrengthSourceCode=@d_drug_strength_source_code,qty1=@d_qty1,qty2=@d_qty2,Qty1Units=@d_qty1_units,Qty2Units=@d_qty2_units,Qty1Enum=@d_qty1_enum,Qty2Enum=@d_qty2_enum 
		,dosage1=@d_dosage1,DaysSupply=@d_days_supply,date1=@d_date1,date2=@d_date2,date3=@d_date3,Date1Enum=@d_date1_enum,Date2Enum=@d_date2_enum,Date3Enum=@d_date3_enum,SubstitutionCode=@d_substitution_code, 
		refills=@d_refills,RefillsType=@d_refills_enum,comments1=@d_comments1,DocInfoText=@d_doc_info_text 
		WHERE FillReqId = @refillRequestId
	 END

	 UPDATE prescription_details SET has_rxfillstatus=1 WHERE pd_id=@RxDetailId AND pres_id=@RxId
            
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
