SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SavePatientInsuranceCoverage]
@PatientId BIGINT,
@InsuranceGrpNumb VARCHAR(60),
@HolderID VARCHAR(60),
@HolderFirstName VARCHAR(100),
@HolderMI VARCHAR(50),
@HolderLastName VARCHAR(100),
@InsurancePlanID VARCHAR(60),
@InsuranceRelateCode VARCHAR(4),
@InsurancePersonCode VARCHAR(4),
@CopayID VARCHAR(40),
@FormularyID VARCHAR(30),
@CoverageListID VARCHAR(40),
@AlternativeID VARCHAR(30),
@BinNumber VARCHAR(60),
@PBMId VARCHAR(15),
@MemberNumber VARCHAR(80),
@MailOrderCoverage VARCHAR(5),
@RetailCoverage VARCHAR(5),
@srcType TINYINT,
@PlanName VARCHAR(100),
@CoveragePatientDetailsAddress1 VARCHAR(100),
@CoveragePatientDetailsAddress2 VARCHAR(100),
@CoveragePatientDetailsCity VARCHAR(50),
@CoveragePatientDetailsState VARCHAR(50),
@CoveragePatientDetailsZipCode VARCHAR(50),
@CoveragePatientDetailsDOB SMALLDATETIME,
@CoveragePatientDetailsSex BIT,
@IsPBMPatientDiff BIT,
@LTCCoverage VARCHAR(5),
@SpecialtyCoverage VARCHAR(5),
@PrimaryPayer VARCHAR(50),
@SecondaryPayer VARCHAR(50),
@TertiaryPayer VARCHAR(50),
@ReturnedPBMName VARCHAR(50),
@TransactionMessageId VARCHAR(50),
@PCN VARCHAR(80)
--@PatientCovId BIGINT OUTPUT

AS
BEGIN
    SET NOCOUNT ON
	INSERT INTO patients_coverage_info (pa_id,ic_group_numb,card_holder_id,card_holder_first,card_holder_mi,card_holder_last,ic_plan_numb,ins_relate_code,ins_person_code,copay_id,formulary_id,coverage_id,alternative_id,pa_bin,pa_notes,rxhub_pbm_id,pbm_member_id,def_ins_id,mail_order_coverage,retail_pharmacy_coverage,formulary_type,add_date,ic_plan_name,PA_ADDRESS1,PA_ADDRESS2,PA_CITY,PA_STATE,PA_ZIP,PA_DOB,PA_SEX,pa_diff_info,longterm_pharmacy_coverage,specialty_pharmacy_coverage,prim_payer,sec_payer,ter_payer,ss_pbm_name,transaction_message_id,PCN)
	VALUES(@PatientId,@InsuranceGrpNumb ,@HolderID ,@HolderFirstName,@HolderMI ,@HolderLastName ,@InsurancePlanID ,@InsuranceRelateCode,@InsurancePersonCode ,@CopayID ,@FormularyID ,@CoverageListID ,@AlternativeID,@BinNumber ,'',@PBMId ,@MemberNumber ,0,@MailOrderCoverage ,@RetailCoverage ,@srcType,getdate(),@PlanName ,@CoveragePatientDetailsAddress1,@CoveragePatientDetailsAddress2 ,@CoveragePatientDetailsCity,@CoveragePatientDetailsState ,@CoveragePatientDetailsZipCode,@CoveragePatientDetailsDOB ,@CoveragePatientDetailsSex,@IsPBMPatientDiff,@LTCCoverage ,@SpecialtyCoverage ,@PrimaryPayer,@SecondaryPayer ,@TertiaryPayer ,@ReturnedPBMName ,@TransactionMessageId ,@PCN )
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
