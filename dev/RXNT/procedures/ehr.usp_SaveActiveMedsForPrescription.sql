SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	22-DECEMBER-2016
Description			:	This procedure is used to Save Active Meds For Prescription
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SaveActiveMedsForPrescription]	
	@PatientId BIGINT,
	@DrugId BIGINT,
	@MainDoctorId BIGINT,
	@DoctorId BIGINT,
	@FromPDId BIGINT,
	@Compound BIT,
	@DateAdded DATETIME,
	@Comments VARCHAR(255),
	@Status TINYINT,
	@DateStatusChange DATETIME,
	@ChangeDoctorId INT,
	@Reason VARCHAR(255),
	@DrugName VARCHAR(255),
	@Dosage VARCHAR(255),
	@DurationAmount VARCHAR(255),
	@DurationUnit VARCHAR(255),
	@DrugComments VARCHAR(255),
	@NoOfRefills INT,
	@IsUseGeneric INT,
	@DaysSupply SMALLINT,
	@IsPrn BIT,
	@PrnDescription VARCHAR(255),
	@DateStart DATETIME,
	@DateEnd DATETIME,
	@OrderReason VARCHAR(500)=NULL
AS
BEGIN

	DECLARE @PD_PatientId BIGINT,
	@PD_DrugId BIGINT,
	@PD_MainDoctorId BIGINT,
	@PD_DoctorId BIGINT,
	@PD_Compound BIT,
	@PD_DateAdded DATETIME,
	@PD_Comments VARCHAR(255),
	@PD_Status TINYINT,
	@PD_DateStatusChange DATETIME,
	@PD_ChangeDoctorId INT,
	@PD_Reason VARCHAR(255),
	@PD_DrugName VARCHAR(255),
	@PD_Dosage VARCHAR(255),
	@PD_DurationAmount VARCHAR(255),
	@PD_DurationUnit VARCHAR(255),
	@PD_DrugComments VARCHAR(255),
	@PD_NoOfRefills INT,
	@PD_IsUseGeneric INT,
	@PD_DaysSupply SMALLINT,
	@PD_IsPrn BIT,
	@PD_PrnDescription VARCHAR(255),
	@PD_DateStart DATETIME,
	@PD_DateEnd DATETIME,
	@PD_OrderReason VARCHAR(500)=NULL

	SELECT 
	@PD_PatientId = pres.pa_id,
	@PD_DrugId = pd.ddid,
	@PD_MainDoctorId = pres.dr_id,
	@PD_DoctorId = pres.prim_dr_id,
	@PD_Compound = pd.compound,
	@PD_DateAdded = pres.pres_entry_date,
	@PD_Comments = '',
	@PD_Status=0,
	@PD_DateStatusChange = NULL,
	@PD_ChangeDoctorId = NULL,
	@PD_Reason = '',
	@PD_DrugName = pd.drug_name,
	@PD_Dosage = pd.dosage,
	@PD_DurationAmount = pd.duration_amount,
	@PD_DurationUnit = pd.duration_unit,
	@PD_DrugComments= pd.comments,
	@PD_NoOfRefills = pd.numb_refills,
	@PD_IsUseGeneric = pd.use_generic,
	@PD_DaysSupply = pd.days_supply,
	@PD_IsPrn = pd.prn,
	@PD_PrnDescription = pd.prn_description,
	@PD_DateStart = ISNULL(pres.pres_start_date,'1901-01-01 00:00:00.000'),
	@PD_DateEnd = ISNULL(pres.pres_end_date,'1901-01-01 00:00:00.000'),
	@PD_OrderReason = pd.order_reason
	FROM prescription_details pd WITH(NOLOCK)
	INNER JOIN prescriptions pres WITH(NOLOCK) ON pd.pres_id=pres.pres_id
	WHERE pd.pd_id=@FromPDId AND pres.pa_id=@PatientId
	 

	IF EXISTS (SELECT PA_ID FROM PATIENT_ACTIVE_MEDS WITH(NOLOCK) WHERE PA_ID = @PatientId  AND DRUG_ID = @DrugId)
	BEGIN
		SELECT @DateStart = date_start FROM PATIENT_ACTIVE_MEDS WHERE PA_ID = @PatientId  AND DRUG_ID = @DrugId
		INSERT INTO [bk].[patient_active_meds]([pam_id],[pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id],[reason],[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description],[date_start],[date_end],[for_dr_id],[source_type],[record_source],[created_date],[active],[last_modified_date],[last_modified_by],[pa_merge_reqid],[PatientUnmergeRequestId])
		SELECT [pam_id],[pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id],[reason],[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description],[date_start],[date_end],[for_dr_id],[source_type],[record_source],GETDATE(),[active],[last_modified_date],[last_modified_by],NULL,NULL
		FROM PATIENT_ACTIVE_MEDS WITH(NOLOCK) 
		WHERE PA_ID = @PatientId  AND DRUG_ID = @DrugId

	END
		

	DELETE FROM PATIENT_ACTIVE_MEDS WHERE PA_ID = @PD_PatientId  AND DRUG_ID = @PD_DrugId
		
	INSERT INTO [dbo].[patient_active_meds] 
	([pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id],[reason],[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description], [date_start], [date_end], [for_dr_id], [order_reason])
    VALUES (@PD_PatientId, @PD_DrugId, @PD_DateAdded, @PD_DoctorId, @FromPDId, @PD_Compound, Left(@PD_Comments, 255), @PD_Status, @PD_DateStatusChange, @PD_ChangeDoctorId, left(@PD_Reason, 150), @PD_DrugName, left(@PD_Dosage, 255), @PD_DurationAmount, @PD_DurationUnit, left(@PD_DrugComments,255), @PD_NoOfRefills, @PD_IsUseGeneric, @PD_DaysSupply, @PD_IsPrn, left(@PD_PrnDescription,50), @PD_DateStart, @PD_DateEnd, @PD_MainDoctorId, @PD_OrderReason)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
