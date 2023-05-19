SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 25-July-2016
-- Description:	Search Paient Immunizations
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_SearchPatientImmunizations]
	@PatientId BIGINT,
	@DoctorId BIGINT
AS
BEGIN
	SELECT DISTINCT a.VAC_REC_ID, a.vac_name, G.vac_group_name vac_base_name,vis_date, vis_given_date,
	 a.VAC_ID, VAC_PAT_ID,VAC_DT_ADMIN, VAC_LOT_NO, VAC_SITE, VAC_DOSE, VAC_EXP_DATE, VAC_DR_ID, 
	 VAC_REACTION, VAC_REMARKS,a.vac_site_code,a.vac_dose_unit_code,a.vac_administered_code, 
	 a.vac_administered_by,a.vac_entered_by,a.substance_refusal_reason_code, a.disease_code,M.manufacturer_name as manufacturer,a.route,
	 b.cvx_code,b.mvx_code,a.route_code,a.eligibility_category_code,c.exportedDate,a.VFC_Eligibility_Status, 
	 b.Expiration_Date, d.dr_first_name,d.dr_last_name,d.professional_designation 
	 from tblVaccinationRecord a 
	 inner join tblvaccines b on a.vac_id= b.vac_id 
	 inner join  tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code
	 inner join tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
	 Inner Join tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
	 Inner JOIN tblVaccineManufacturers M ON b.manufacturer_Id=M.manufacturer_Id
	 left join tblVaccinationQueue c on c.vac_rec_id=a.vac_rec_id 
		AND c.queue_id =(SELECT TOP 1 queue_id FROM tblVaccinationQueue WHERE pat_id=@PatientId AND dr_id=@DoctorId AND vac_rec_id=a.vac_rec_id AND isIncluded=1 AND exportedDate IS NOT NULL ORDER BY exportedDate DESC) 
	 Left Outer Join doctors d with(nolock) On d.dr_id=a.vac_administered_by where VAC_PAT_ID =@PatientId 
	 order by G.vac_group_name ASC,a.vac_name ASC,VAC_DT_ADMIN ASC;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
