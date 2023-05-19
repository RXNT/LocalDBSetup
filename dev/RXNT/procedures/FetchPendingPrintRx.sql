SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchPendingPrintRx]
	@DoctorId int, @DoctorGroupId int
AS
BEGIN
	SET NOCOUNT ON;
	IF @DoctorId > 0 and @DoctorGroupId > 0
		BEGIN
			SELECT PPQ.pres_print_id PrintJobId,PPQ.PRES_ID PrescriptionId,pd.drug_name DrugName, pd.dosage Dosage,
			dr.dr_last_name DoctorLastName, dr.dr_first_name DoctorFirstName,
			pt.pa_last PatientLastName,pt.pa_first PatientFirstName,
			pt.pa_address1 PatientAddress1,pt.pa_city PatientCity,pt.pa_state PatientState,
			pt.pa_zip PatientZip, pt.pa_phone PatientPhone,
			CASE WHEN ph.pharm_company_name IS NULL THEN '' ELSE ph.pharm_company_name END PharmacyName,
			CASE WHEN ph.pharm_address1 IS NULL THEN '' ELSE ph.pharm_address1 END PharmacyAddress1,
			CASE WHEN ph.pharm_city IS NULL THEN '' ELSE ph.pharm_city END PharmacyCity,
			CASE WHEN ph.pharm_state IS NULL THEN '' ELSE ph.pharm_state END PharmacyState,
			CASE WHEN ph.pharm_zip IS NULL THEN '' ELSE ph.pharm_zip END PharmacyZip,
			CASE WHEN ph.pharm_phone IS NULL THEN '' ELSE ph.pharm_phone END PharmacyPhone
			 FROM prescription_print_queue ppq INNER JOIN 
				prescriptions P ON PPQ.PRES_ID=P.pres_id INNER JOIN
				prescription_details PD ON P.pres_id=PD.pres_id INNER JOIN
				doctors DR on P.dr_id = DR.dr_id INNER JOIN
				patients pt ON P.pa_id=pt.pa_id LEFT OUTER JOIN
				PHARMACIES PH ON P.PHARM_ID=PH.PHARM_ID 
				WHERE P.dg_id=@DoctorGroupId AND P.dr_id=@DoctorId AND NOT(P.pres_approved_date IS NULL) AND PPQ.print_complete_date IS NULL 
		END   
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
