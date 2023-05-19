SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      
CREATE PROCEDURE [support].[usp_CreateDummyRxPharmacyRequests] -- [support].[usp_CreateDummyRxPharmacyRequests] @Username = 'internaldemo',@NoOfRefillRequestsRequired=50
@Username VARCHAR(50),
@NoOfRefillRequestsRequired INT = 1
AS
BEGIN 
	DECLARE @DoctorGroupId INT,@DoctorCompanyId INT,@DoctorId INT, @AuthorizingDoctorId INT, @IsEPCSEnabled BIT,@PatientId INT,@PharmacyId INT,@RxDetailId INT,
	@DrugId BIGINT,@DrugLevel INT
	SELECT @DoctorId = D.dr_id, @DoctorGroupId=DG.dg_id,@DoctorCompanyId = DG.dc_id, @IsEPCSEnabled = D.epcs_enabled
	FROM doctors D WITH(NOLOCK)
	INNER JOIN DOC_GROUPS DG  WITH(NOLOCK) ON D.DG_ID = DG.DG_ID  
	WHERE dr_username =@Username

	
	DECLARE @MessageId AS VARCHAR(50),
		@DoctorSPI VARCHAR(50),
		@PrescriberOrderNumber BIGINT,
		@DoctorObjectText VARCHAR(MAX),
		@AgentInfo VARCHAR(MAX),
		@SupervisorObjectText VARCHAR(MAX),
		@SupervisorInfo VARCHAR(MAX),
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
		@recverVector VARCHAR(50), 
		@senderVector VARCHAR(50),
		@init_date DATETIME,
		@msg_date DATETIME, 
		@msg_ref_number VARCHAR(35),
		@PharmSeg VARCHAR(MAX),
		@PatientSeg VARCHAR(MAX),
		@DispDRUSeg VARCHAR(MAX),
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
		@p_doc_info_text VARCHAR(MAX),
		@HasDispensedDrug BIT=1,
		@d_drug_name VARCHAR(125),
		@d_drug_ndc VARCHAR(11),
		@d_drug_level INT=NULL,
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
		@d_doc_info_text VARCHAR(MAX),
		@RxNTRxType INT=2,
		@RxSrc INT,
		@Dosage VARCHAR(255),
		@IsUseGeneric BIT,
		@NoOfRefills INT,
		@Comments VARCHAR(255),
		@DurationAmount VARCHAR(15),
		@DurationUnitCode VARCHAR(10),
		@DaysSupply SMALLINT,
		@IsRefillsPrn BIT
	DECLARE @DurationUnit VARCHAR(255),@ScriptGuideId INT,@ScriptGuideStatus TINYINT
	DECLARE db_cursor CURSOR FOR 
	SELECT TOP (@NoOfRefillRequestsRequired) pres.pres_id,pd.duration_unit,pd.duration_amount,pres.authorizing_dr_id,pres.pharm_id,ph.ncpdp_numb,pres.pa_id,pd.ddid,pd.drug_name,pd.dosage,pd.use_generic,pd.numb_refills,pd.comments
	FROM prescriptions pres WITH(NOLOCK) 
	INNER JOIN prescription_details pd WITH(NOLOCK) ON pres.pres_id = pd.pres_id
	INNER JOIN pharmacies ph WITH(NOLOCK) ON ph.pharm_id = pres.pharm_id
	WHERE pres.dr_id=@DoctorId
	ORDER BY pres.pres_id DESC
	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @PrescriberOrderNumber,@DurationUnit,@DurationAmount,@AuthorizingDoctorId,@PharmacyId,@PharmacyNCPDPNumber,@PatientId, @DrugId,@DrugName,@Dosage,@IsUseGeneric,@NoOfRefills,@Comments
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		DECLARE @MaxRefillRquestId BIGINT
		SELECT @MaxRefillRquestId=MAX(ISNULL(refreq_id,0))+1 
		FROM refill_requests WITH(NOLOCK)
		
		SET @MessageId = 'DummyRefillMessageId_'+ CAST(@MaxRefillRquestId AS  VARCHAR(50))

		SET @p_drug_name = @DrugName
		SET @d_drug_name = @DrugName
		SET @p_refills = @NoOfRefills
		SET @d_refills = @NoOfRefills
		SET @p_comments1 = @Comments
		SET @d_comments1 = @Comments
		SET @p_disp_drug_info = 0
		SET @refreq_date = GETDATE()
		SELECT TOP 1 @ndc=ndc,@DrugLevel=B.med_REF_DEA_CD 
		FROM rmindc1 a WITH(NOLOCK)   
		INNER JOIN rmiid1 b  WITH(NOLOCK)  ON a.medid=b.medid   
		WHERE  b.medid=@DrugId

		SELECT TOP 1 @DurationUnitCode=ISNULL(potency_unit_code,'C38046') 
		FROM duration_units WITH(NOLOCK) 
		WHERE du_text = @DurationUnit
			
		SET @p_qty1 = @DurationAmount
		SET @p_qty1_units=@DurationUnit;
		SET @d_drug_ndc=@NDC

		DECLARE @RxId BIGINT
		DECLARE @RxEntryDate DATETIME=GETDATE()
		EXECUTE @RxId = [eRx2019].[usp_SavePatientRx] @RxId=NULL,@PatientId = @PatientId,@DoctorId = @DoctorId,@DoctorGroupId = @DoctorGroupId, @PharmacyId = @PharmacyId,@PrimaryDoctorId = @DoctorId, @DeliveryMethod = 262144,@IsSigned = 0, @PrintingOptions = 0,@IsVoid = 0,@RxNTRxType = @RxNTRxType,@RxEntryDate = @RxEntryDate,@RxApprovedDate=NULL,@IsEligibilityChecked = 0,@EligibilityTransactionId=NULL,@Src = @RxSrc,@StartDate = NULL,@EndDate = NULL,@VoidComments = '',@VoidCode = NULL,@AuthorizingDoctorId =@AuthorizingDoctorId
		,@DrugName=@d_drug_name,@DrugId =@DrugId,@Dosage =@Dosage,@MaxDailyDosage =NULL,@IsUseGeneric=@IsUseGeneric,@NoOfRefills=@NoOfRefills,@Comments =@Comments,@DurationAmount =@DurationAmount,@DurationUnit =@DurationUnit,@IsPrn =0,@IsAsDirected =0,@DoIncludeInPrint =0,@DoIncludeInPharmDelivery =0,@PrnDescription ='',@IsCompound =0,@DiagnosisCode ='',@DaysSupply=@DaysSupply,@IsRefillsPrn=@IsRefillsPrn,@AgentInfo =@AgentInfo,@SupervisorInfo =@SupervisorInfo,@OrderReason =NULL,@DiagnosisCodeDescription =NULL,@Pain =NULL,@ScriptGuideId =@ScriptGuideId,@ScriptGuideStatus =@ScriptGuideStatus,@PatientHeight=@PatientHeight,@PatientWeight=@PatientWeight
		SET @msg_ref_number ='Dummy_RxReferenceNumber_'+CAST(@RxId AS VARCHAR(50))
		DECLARE @refillRequestId AS INT 
		INSERT INTO refill_requests (dg_id, dr_id, pa_id, pharm_id, pharm_ncpdp, pres_id, refreq_date, trc_number, ctrl_number, recverVector, senderVector, init_date, msg_date, msg_ref_number,PharmSeg,PatientSeg,SupervisorSeg,DoctorSeg,DispDRUSeg,PrescDRUSeg,fullRequestMessage,versionType,has_miss_match,miss_match_reson) 
		VALUES (@DoctorGroupId, @DoctorId, @PatientId, @PharmacyId, @PharmacyNCPDPNumber, @RxId, @refreq_date, @PrescriberOrderNumber, @MessageId, @recverVector, @senderVector, @init_date,@msg_date, @msg_ref_number,@PharmSeg,@PatientSeg,@SupervisorObjectText,@DoctorObjectText,@DispDRUSeg,@PrescDRUSeg,@fullRequestMessage,@versionType,0,NULL); 
  
		SET @refillRequestId =SCOPE_IDENTITY()
                
		--Save Prescribed Drug Info
		UPDATE refill_requests SET drug_name=@p_drug_name,drug_ndc=@p_drug_ndc,drug_form_code=@p_drug_form_code,drug_form_source_code=@p_drug_form_source_code,drug_strength=@p_drug_strength,drug_strength_code=@p_drug_strength_code,drug_strength_source_code=@p_drug_strength_source_code,qty1=@p_qty1,qty2=@p_qty2,qty1_units=@p_qty1_units,qty2_units=@p_qty2_units,qty1_enum=@p_qty1_enum,qty2_enum=@p_qty2_enum 
			,dosage1=@p_dosage1,days_supply=@p_days_supply,date1=@p_date1,date2=@p_date2,date3=@p_date3,date1_enum=@p_date1_enum,date2_enum=@p_date2_enum,date3_enum=@p_date3_enum,substitution_code=@p_substitution_code, 
			refills=@p_refills,refills_enum=@p_refills_enum,comments1=@p_comments1,disp_drug_info=@p_disp_drug_info,doc_info_text=@p_doc_info_text WHERE refreq_id = @refillRequestId
	 
			IF @HasDispensedDrug = 1
			BEGIN
				INSERT INTO refill_requests_info (refreq_id, type) VALUES (@refillRequestId,'D')
				--Save Dispensed Drug Info
				UPDATE refill_requests_info SET drug_name=@d_drug_name,drug_ndc=@d_drug_ndc,drug_form_code=@d_drug_form_code,drug_form_source_code=@d_drug_form_source_code,drug_strength=@d_drug_strength,drug_strength_code=@d_drug_strength_code,drug_strength_source_code=@d_drug_strength_source_code,qty1=@d_qty1,qty2=@d_qty2,qty1_units=@d_qty1_units,qty2_units=@d_qty2_units,qty1_enum=@d_qty1_enum,qty2_enum=@d_qty2_enum 
						,dosage1=@d_dosage1,days_supply=@d_days_supply,date1=@d_date1,date2=@d_date2,date3=@d_date3,date1_enum=@d_date1_enum,date2_enum=@d_date2_enum,date3_enum=@d_date3_enum,substitution_code=@d_substitution_code, 
						refills=@d_refills,refills_enum=@d_refills_enum,comments1=@d_comments1,doc_info_text=@d_doc_info_text WHERE refreq_id = @refillRequestId
			END

		FETCH NEXT FROM db_cursor INTO @PrescriberOrderNumber,@DurationUnit,@DurationAmount,@AuthorizingDoctorId,@PharmacyId,@PharmacyNCPDPNumber,@PatientId, @DrugId,@DrugName,@Dosage,@IsUseGeneric,@NoOfRefills,@Comments
	END
	CLOSE db_cursor  
	DEALLOCATE db_cursor 
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
