SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 4-Aug-2016
-- Description:	To Get patient vaccination record
-- Modified By: Reiah
-- Description: To Get patient vaccination record and Deleted Information if records has deleted already
-- Modified Date: 08-Oct-2017
-- =============================================

CREATE PROCEDURE [enc].[usp_GetPatientVaccinationRecordList] 
 @MainDoctorId INT,
 @PatientId INT
AS
BEGIN
	
	SELECT a.VAC_PAT_ID,a.VAC_REC_ID, b.vac_name, ISNULL(G.vac_group_name,b.vac_base_name) as vac_base_name, b.comments, b.Expiration_Date, 
	vis_date, vis_given_date, a.VAC_ID, VAC_PAT_ID, VAC_DT_ADMIN, VAC_LOT_NO, VAC_SITE, VAC_DOSE, 
	VAC_EXP_DATE, VAC_DR_ID, VAC_REACTION, VAC_REMARKS,a.vac_site_code,a.vac_dose_unit_code,
	a.vac_administered_code,a.vac_administered_by,a.vac_entered_by,a.substance_refusal_reason_code,
	a.disease_code,a.VFC_Eligibility_Status,a.vfc_code,M.manufacturer_name as manufacturer ,a.route,b.cvx_code,b.mvx_code,a.route_code,
	a.eligibility_category_code, VGM.vac_group_id, 
	c.isIncluded,
	c.exportedDate, 
	d.dr_first_name,d.dr_last_name,d.professional_designation 
	,isnull(a.active, 1) as immunization_active_status,
		deletedby.dr_first_name as immunization_dr_fname,deletedby.dr_last_name  as immunization_dr_lname,a.[last_modified_date] as immunization_deleted_on,
		VIS.vis_edition_date as vis_edition_date,a.vis_edition_date as free_text_vis_edition_date
	from tblVaccinationRecord a 
	inner join tblvaccines b on a.vac_id= b.vac_id  
	LEFT OUTER JOIN  tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code
	LEFT OUTER JOIN tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
	LEFT OUTER JOIN tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
	LEFT OUTER JOIN tblVaccineManufacturers M ON b.manufacturer_Id=M.manufacturer_Id
	LEFT OUTER JOIN tblVaccineCVXToVISMappings VISM ON CVX.cvx_id=VISM.cvx_id
	LEFT OUTER JOIN tblVaccineVIS VIS ON VIS.vis_concept_id=VISM.vis_concept_id
	left join tblVaccinationQueue c on c.vac_rec_id=a.vac_rec_id 
		AND c.queue_id =(SELECT TOP 1 queue_id FROM tblVaccinationQueue
			WHERE vac_rec_id=a.vac_rec_id AND isIncluded=1 AND exportedDate IS NOT NULL ORDER BY exportedDate DESC) 
	Left Outer Join doctors d with(nolock) On d.dr_id=a.vac_administered_by
	Left Outer Join doctors deletedby with(nolock) On deletedby.dr_id=a.last_modified_by
	where a.vac_pat_id =@PatientId  
	AND ISNULL(a.active,1) = 1 AND a.record_modified_date >= DATEADD(day, -1, GETDATE())  
 order by VAC_DT_ADMIN desc
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
