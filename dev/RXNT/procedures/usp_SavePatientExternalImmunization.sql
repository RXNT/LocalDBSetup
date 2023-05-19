SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 02/23/2022
-- Description:	Save patient external vaccine records
-- =============================================

CREATE PROCEDURE [dbo].[usp_SavePatientExternalImmunization]
	@VaccineRecordId INT OUTPUT,
	@VaccineId INT,
	@VaccineName VARCHAR(150),
	@PatientId INT,
	@DateAdministered DATETIME,
	@LotNumber VARCHAR(50),
	@Site VARCHAR(100),
	@Dose VARCHAR(225),
	@ExpirationDate DATETIME,
	@VISDate DATETIME,
	@VISGivenDate DATETIME,
	@RequestId INT,
	@Reaction VARCHAR(512),
	@Remarks VARCHAR(512),
	@SiteCode VARCHAR(10),
	@DoseUnitCode VARCHAR(20),
	@AdministeredBy INT,
	@SubstanceRefusalReasonCode VARCHAR(2),
	@AdministeredCode VARCHAR(2),
	@EnteredBy INT,
	@DiseaseCode VARCHAR(10),
	@VFCEligibilityStatus VARCHAR(10),
	@VFCCode VARCHAR(10) = NULL,
	@FundingProgramEligibilityCategoryCode VARCHAR(15),
	@Route VARCHAR(50),
	@RouteCode VARCHAR(50),
	@VaccineAdminStatus VARCHAR(50) = NULL,
	@FreeTextVISDate VARCHAR(50) = NULL,
	@MessageControlId VARCHAR(100),
	@CVXCode VARCHAR(10),
	@MVXCode VARCHAR(10) = NULL,
	@ManufacturerName NVARCHAR(100) = NULL,
	@IsReconciled BIT = 0
AS
BEGIN
	IF ISNULL(@VaccineRecordId,0) = 0
	BEGIN
		INSERT INTO [tblPatientExternalVaccinationRecord] 
		(
			vac_id,
			vac_name,
			vac_pat_id,
			vac_dt_admin,
			vac_lot_no,
			vis_date,
			vis_given_date,
			vac_site,
			vac_dose,
			vac_exp_date,
			request_id,
			vac_reaction,
			vac_remarks,
			vac_site_code,
			vac_dose_unit_code,
			vac_administered_by,
			vac_administered_code,
			substance_refusal_reason_code,
			vac_entered_by,
			disease_code,
			vfc_eligibility_status,
			vfc_code,eligibility_category_code,
			route,
			route_code,
			active,
			vaccine_admin_status,
			action_code,
			vis_edition_date,
			message_control_id,
			cvx_code,
			mvx_code,
			manufacturer_name,
			is_reconciled
		) 
		VALUES 
		(
			@VaccineId,
			@VaccineName,
			@PatientId,
			@DateAdministered,
			@LotNumber,
			@VISDate,
			@VISGivenDate, 
			@Site,
			@Dose,
			@ExpirationDate,
			@RequestId,
			@Reaction,
			@Remarks,
			@SiteCode,
			@DoseUnitCode,
			@AdministeredBy,
			@AdministeredCode,
			@SubstanceRefusalReasonCode,
			@EnteredBy,
			@DiseaseCode,
			@VFCEligibilityStatus,
			@VFCCode,
			@FundingProgramEligibilityCategoryCode,
			@Route,
			@RouteCode,
			1,
			@VaccineAdminStatus,
			'A',
			@FreeTextVISDate,
			@MessageControlId,
			@CVXCode,
			@MVXCode,
			@ManufacturerName,
			@IsReconciled
		);
		SET @VaccineRecordId = SCOPE_IDENTITY();
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
