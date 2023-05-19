SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 12-Dec-2018
-- Description:	To Save patient immunization (Referred Patient Dashboard)
-- Modified By: 
-- =============================================
CREATE PROCEDURE [enc].[usp_SavePatientImmunization]
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
	@UserId INT,
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
	@Route varchar(50),
	@RouteCode varchar(50),
	@VaccineAdminStatus varchar(50) = NULL,
	@FreeTextVISDate varchar(50) = NULL,
	@VaccinationStatus BIT
	
	
AS
BEGIN
	IF ISNULL(@VaccineRecordId,0) = 0
	BEGIN
	INSERT INTO [tblVaccinationRecord] 
	([vac_id],[vac_name], [vac_pat_id],[vac_dt_admin],[vac_lot_no],[vis_date], [vis_given_date] 
	,[vac_site],[vac_dose],[vac_exp_date],[vac_dr_id],[vac_reaction],[vac_remarks],vac_site_code
	,vac_dose_unit_code,vac_administered_by,vac_administered_code,substance_refusal_reason_code
	,vac_entered_by,disease_code,VFC_Eligibility_Status,vfc_code,eligibility_category_code, [route], route_code
	, active,vaccine_admin_status,action_code,vis_edition_date) 
	VALUES 
	(@VaccineId, @VaccineName, @PatientId, @DateAdministered,@LotNumber, @VISDate, @VISGivenDate, 
	@Site, @Dose, @ExpirationDate, @UserId, @Reaction, @Remarks,@SiteCode,
	@DoseUnitCode,@AdministeredBy,@AdministeredCode,@SubstanceRefusalReasonCode,
	@EnteredBy,@DiseaseCode,@VFCEligibilityStatus,@VFCCode,@FundingProgramEligibilityCategoryCode,
	@Route,@RouteCode,1,@VaccineAdminStatus,'A',@FreeTextVISDate);
	SET @VaccineRecordId = SCOPE_IDENTITY();
	END
	Else
	BEGIN
		update tblVaccinationRecord 
		set  vac_dt_admin=@DateAdministered, 
		vac_lot_no=@LotNumber, 
		vis_date=@VISDate, 
		vis_given_date=@VISGivenDate, 
		vac_site=@Site, 
		vac_dose=@Dose, 
		vac_exp_date=@ExpirationDate, 
		vac_reaction=@Reaction, 
		vac_remarks =@Remarks,
		vac_site_code=@SiteCode,
		vac_dose_unit_code=@DoseUnitCode,
		vac_administered_by=@AdministeredBy,
		vac_administered_code=@AdministeredCode,
		substance_refusal_reason_code=@SubstanceRefusalReasonCode,
		vac_entered_by=@EnteredBy,
		disease_code=@DiseaseCode,
		VFC_Eligibility_Status=@VFCEligibilityStatus, 
		vac_id=@VaccineId,
		vac_name = @VaccineName,
		vfc_code = @VFCCode,
		eligibility_category_code=@FundingProgramEligibilityCategoryCode,
		[route]=@Route,
		route_code=	@RouteCode,
		vaccine_admin_status = @VaccineAdminStatus,
		action_code = 'U',
		vis_edition_date=@FreeTextVISDate,
		active=@VaccinationStatus
		where vac_rec_id = @VaccineRecordId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
