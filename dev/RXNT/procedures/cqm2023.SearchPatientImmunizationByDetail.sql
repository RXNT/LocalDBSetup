SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Patient Immunization by detail
-- =============================================
CREATE    PROCEDURE [cqm2023].[SearchPatientImmunizationByDetail]
	@VaccineId INT,
	@VaccineName VARCHAR(150),
	@PatientId INT,
	@DateAdministered DATETIME=NULL,
	@LotNumber VARCHAR(50),
	@Dose VARCHAR(225),
	@ExpirationDate DATETIME=NULL,
	@VISDate DATETIME=NULL,
	@VISGivenDate DATETIME=NULL,
	@UserId INT,
	@DoseUnitCode VARCHAR(20)
AS
BEGIN
	DECLARE @ImmunId AS BIGINT=0
	
	SELECT @ImmunId=vac_rec_id FROM tblVaccinationRecord
	WHERE vac_id=@VaccineId AND vac_name=@VaccineName AND vac_pat_id=@PatientId AND CONVERT(VARCHAR(10), vac_dt_admin, 101)=@DateAdministered AND vac_lot_no=@LotNumber AND
	CONVERT(VARCHAR(10), vis_date, 101)=@VISDate AND CONVERT(VARCHAR(10), vis_given_date, 101)=@VISGivenDate 
	AND vac_dose=@Dose AND CONVERT(VARCHAR(10), vac_exp_date, 101)=@ExpirationDate AND vac_dr_id=@UserId
	AND vac_dose_unit_code=@DoseUnitCode AND active=1
	
	SELECT @ImmunId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
