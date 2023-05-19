SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 13-Sep-2016
-- Description:	To save lab results
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveLabResults]
	@LabId INT OUTPUT,
	@SendingApplicationName VARCHAR(1000),
	@SendingApplicationFacility VARCHAR(1000),
	@ReceivingApplicationName VARCHAR(1000),
	@ReceivingApplicationFacility VARCHAR(1000),
	@MessageDate DATETIME,
	@MessageType VARCHAR(50),
	@MessageCtrlId VARCHAR(100),
	@Version VARCHAR(10),
	@ComponentSep VARCHAR(1),
	@SubcomponentSep VARCHAR(1),
	@EscapeDelim VARCHAR(1),
	@DoctorId INT,
	@PatientId INT,
	@DoctorGroupId INT,
	@IsRead BIT,
	@ProviderName VARCHAR(500),
	@Comments VARCHAR(MAX),
	@Type VARCHAR(10),
	
	@LabPatientId VARCHAR(1000),
	@PatientFirstName VARCHAR(200),
	@PatientLastName VARCHAR(200),
	@PatientMiddleName VARCHAR(200),
	@PatientDOB DATETIME,
	@PatientSex VARCHAR(3),
	@PatientAddress VARCHAR(200),
	@PatientCity VARCHAR(200),
	@PatientState VARCHAR(5),
	@PatientZip VARCHAR(200),
	@PatientAccountNumber VARCHAR(200),
	@Fasting VARCHAR(200),
	@SpmStatus VARCHAR(200),
	
	@LabOrderId INT OUTPUT,
	@SpecimenId VARCHAR(1000),
	@FilterAccessionId VARCHAR(1000),
	@OrderDate DATETIME,
	@OrderProviderId VARCHAR(1000),
	@CallBackNo VARCHAR(100),
	@ProviderFirstName VARCHAR(100),
	@ProviderLastName VARCHAR(100),
	@ProviderMiddleInitial VARCHAR(100),
	
	@LabResultInfoId INT OUTPUT,
	@TesNumber VARCHAR(500),
	@TestName VARCHAR(500),
	@CodingSystem VARCHAR(500),
	@ObservationDate DATETIME,
	@ActCode TINYINT,
	@ClinicalInfo VARCHAR(500),
	@SpecimenReceivedDate DATETIME,
	@ReportDate DATETIME,
	@ProducersSection VARCHAR(500),
	@Status TINYINT,
	@Notes VARCHAR(MAX)
AS
BEGIN
-- lab_main --
	INSERT INTO lab_main 
	(send_appl, send_facility, rcv_appl, rcv_facility, 
	message_date, message_type, message_ctrl_id, version,component_sep, subcomponent_sep, escape_delim,
	 dr_id, pat_id, dg_id, is_read,PROV_NAME, comments,type)
	VALUES
	(@ReceivingApplicationName, @SendingApplicationFacility, @ReceivingApplicationName, @ReceivingApplicationFacility,
	@MessageDate, @MessageType, @MessageCtrlId, @Version, @ComponentSep, @SubcomponentSep, @EscapeDelim,
	@DoctorId, @PatientId, @DoctorGroupId, @IsRead, @ProviderName, @Comments, @Type)
	
	SET @LabId = SCOPE_IDENTITY();
	
-- lab_pat_details --
	
	INSERT INTO lab_pat_details
	(lab_id, pat_id, lab_pat_id, pa_first, pa_last, pa_middle, pa_dob, pa_sex, pa_address1, pa_city, pa_state,
	pa_zip, pa_acctno, fasting, spm_status)
	VALUES
	(@LabId, @PatientId, @LabPatientId, @PatientFirstName, @PatientLastName, @PatientMiddleName, @PatientDOB,
	@PatientSex, @PatientAddress, ISNULL(@PatientCity, ''), @PatientState, @PatientZip, @PatientAccountNumber, @Fasting, @SpmStatus)
	
-- lab_order_info

	INSERT INTO lab_order_info 
	(lab_id, spm_id, filler_acc_id, order_date, ord_prv_id, ord_prv_first, ord_prv_last, ord_prv_mi, callback_no)	
	VALUES
	(@LabId, @SpecimenId, @FilterAccessionId, @OrderDate, @OrderProviderId, @ProviderFirstName, @ProviderLastName, @ProviderMiddleInitial, @CallBackNo)
	
	SET @LabOrderId = SCOPE_IDENTITY();
	
-- lab_result_info

	INSERT INTO lab_result_info
	(lab_id, lab_order_id, spm_id, filler_acc_id, obs_bat_ident, obs_ba_test, obs_cod_sys, obs_date,
	act_code, rel_cl_info, dt_spm_rcv, obs_rel_dt, prod_sec_id, ord_result_status, notes)	
	VALUES
	(@LabId, @LabOrderId, @SpecimenId, @FilterAccessionId, @TesNumber, @TestName, @CodingSystem, @ObservationDate,
	@ActCode, @ClinicalInfo, @SpecimenReceivedDate, @ReportDate, @ProducersSection, @Status, @Notes)
	
	SET @LabResultInfoId = SCOPE_IDENTITY()
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
