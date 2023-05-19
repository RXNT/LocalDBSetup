SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SavePatientRx]
@RxId BIGINT=NULL,
@PatientId BIGINT,
@DoctorId BIGINT,
@DoctorGroupId BIGINT,
@PharmacyId BIGINT,
@PrimaryDoctorId BIGINT,
@DeliveryMethod BIGINT,
@IsSigned BIT,
@PrintingOptions INT,
@IsVoid BIT,
@RxNTRxType INT,
@RxEntryDate DATETIME,
@RxApprovedDate DATETIME=NULL,
@IsEligibilityChecked BIT,
@EligibilityTransactionId VARCHAR(50),
@Src INT,
@StartDate DATETIME,
@EndDate DATETIME,
@VoidComments VARCHAR(50),
@VoidCode VARCHAR(50),
@AuthorizingDoctorId BIGINT=NULL,
@DrugName VARCHAR(150),
@DrugId BIGINT,
@Dosage VARCHAR(255),
@MaxDailyDosage VARCHAR(50),
@IsUseGeneric BIT,
@NoOfRefills INT,
@Comments VARCHAR(255),
@DurationAmount VARCHAR(15),
@DurationUnit VARCHAR(255),
@IsPrn BIT,
@IsAsDirected BIT,
@DoIncludeInPrint BIT,
@DoIncludeInPharmDelivery BIT,
@PrnDescription VARCHAR(50),
@IsCompound BIT,
@DiagnosisCode VARCHAR(10),
@DaysSupply SMALLINT,
@IsRefillsPrn BIT,
@AgentInfo VARCHAR(5000),
@SupervisorInfo VARCHAR(5000),
@OrderReason VARCHAR(500),
@DiagnosisCodeDescription VARCHAR(255),
@Pain VARCHAR(30),
@ScriptGuideId INT,
@ScriptGuideStatus TINYINT,
@PatientHeight VARCHAR(50)=NULL,
@PatientWeight VARCHAR(50)=NULL
--@PatientCovId BIGINT OUTPUT

AS
BEGIN
    SET NOCOUNT ON
    IF ISNULL(@RxId,0)>0
    BEGIN
		UPDATE prescriptions SET dr_id = @DoctorId , dg_id =  @DoctorGroupId , pharm_id =  @PharmacyId , pa_id =  @PatientId , 
		pres_delivery_method =  @DeliveryMethod , prim_dr_id =  @PrimaryDoctorId , 
		is_signed =  @IsSigned , 
		print_options =  @PrintingOptions  , pres_approved_date = @RxApprovedDate , 
		pres_void =  @IsVoid , PRES_PRESCRIPTION_TYPE = @RxNTRxType  
		WHERE PRES_ID =  @RxId;
	END
	ELSE
	BEGIN
		INSERT INTO prescriptions (dr_id, dg_id, pharm_id, pa_id, pres_entry_date, pres_approved_date, pres_delivery_method, prim_dr_id, pres_prescription_type, is_signed, eligibility_checked, eligibility_trans_id, print_options, presc_src, pres_start_date, pres_end_date ,pres_void, pres_void_comments, pres_void_code,authorizing_dr_id,writing_dr_id)
		VALUES ( @DoctorId,  @DoctorGroupId, @PharmacyId,  @PatientId, @RxEntryDate,@RxApprovedDate, @DeliveryMethod,  @DoctorId, @RxNTRxType, @IsSigned,  @IsEligibilityChecked,  @EligibilityTransactionId, @PrintingOptions ,  @Src,  @StartDate, @EndDate,@IsVoid,  @VoidComments, @VoidCode,@AuthorizingDoctorId, @PrimaryDoctorId)
                         
		SET @RxId= SCOPE_IDENTITY()
	END
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM prescription_details pd WITH(NOLOCK) WHERE pd.pres_id=@RxId)
	BEGIN
	    INSERT INTO prescription_details (drug_name, pres_id, ddid, dosage, max_daily_dosage, use_generic, numb_refills, comments, duration_amount, duration_unit, prn, as_directed, include_in_print, include_in_pharm_deliver, prn_description, compound, icd9, days_supply , refills_prn , agent_info , supervisor_info, order_reason, icd9_desc, pain, script_guide_id, script_guide_status,pt_height,pt_weight )
		VALUES (@DrugName, @RxId, @DrugId, @Dosage, @MaxDailyDosage, @IsUseGeneric, @NoOfRefills , @Comments, ISNULL(@DurationAmount,''), ISNULL(@DurationUnit,''), @IsPrn,@IsAsDirected, @DoIncludeInPrint,@DoIncludeInPharmDelivery , @PrnDescription,@IsCompound , @DiagnosisCode , @DaysSupply , @IsRefillsPrn , @AgentInfo , @SupervisorInfo, @OrderReason, @DiagnosisCodeDescription, @pain, @ScriptGuideId ,@ScriptGuideStatus,@PatientHeight,@PatientWeight)

    END
    ELSE
    BEGIN
		 UPDATE prescription_details 
		 SET drug_name = @DrugName, ddid =  @DrugId , dosage = @Dosage, max_daily_dosage = @MaxDailyDosage, use_generic = @IsUseGeneric , numb_refills =  @NoOfRefills , comments = @Comments, order_reason = @OrderReason, days_supply =  @DaysSupply  , refills_prn =  @IsRefillsPrn,duration_amount = ISNULL(@DurationAmount,''), duration_unit = ISNULL(@DurationUnit,''), prn =  @IsPrn , as_directed =  @IsAsDirected, include_in_print =  @DoIncludeInPrint , include_in_pharm_deliver =  @DoIncludeInPharmDelivery, icd9 = @DiagnosisCode , icd9_desc = @DiagnosisCodeDescription, prn_description = @PrnDescription,compound=@IsCompound, script_guide_id =  @ScriptGuideId  , script_guide_status =  @ScriptGuideStatus,pain=@Pain 
		 WHERE pres_id =  @RxId;
    END
	RETURN @RxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
