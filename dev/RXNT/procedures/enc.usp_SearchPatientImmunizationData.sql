SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 12-Dec-2018
-- Description:	Search Paient Immunizations Meta Data (Referred Patient Dashboard)

-- =============================================
CREATE PROCEDURE [enc].[usp_SearchPatientImmunizationData]   
	@PatientId BIGINT
AS
BEGIN
	 
 SELECT a.VAC_PAT_ID,a.VAC_REC_ID, b.vac_name,isnull(a.active, 1) as immunization_active_status, G.vac_group_name as vac_base_name, b.comments, b.Expiration_Date, 
 vis_date, vis_given_date, a.VAC_ID, VAC_PAT_ID, VAC_DT_ADMIN, VAC_LOT_NO, VAC_SITE, VAC_DOSE, 
 VAC_EXP_DATE, VAC_DR_ID, VAC_REACTION, VAC_REMARKS,a.vac_site_code,a.vac_dose_unit_code,
 a.vac_administered_code,a.vac_administered_by,a.vac_entered_by,a.substance_refusal_reason_code,
 a.disease_code,a.VFC_Eligibility_Status,a.vfc_code,M.manufacturer_name as manufacturer ,a.route,b.cvx_code,b.mvx_code,a.route_code,
 a.eligibility_category_code, VGM.vac_group_id, 
 c.exportedDate,
 c.isIncluded, 
 d.dr_first_name,d.dr_last_name,d.professional_designation 
 from tblVaccinationRecord a 
 inner join tblvaccines b on a.vac_id= b.vac_id  
 inner join  tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code
 inner join tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
 Inner Join tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
 Inner JOIN tblVaccineManufacturers M ON b.manufacturer_Id=M.manufacturer_Id
 left join tblVaccinationQueue c on c.vac_rec_id=a.vac_rec_id 
		
 Left Outer Join doctors d with(nolock) On d.dr_id=a.vac_administered_by
 where vac_pat_id = @PatientId AND ISNULL(a.active,1) = 1 AND a.record_modified_date >= DATEADD(day, -1, GETDATE())  
 order by VAC_DT_ADMIN desc
	--order by b.vac_base_name ASC,a.vac_name ASC,VAC_DT_ADMIN ASC; old Line
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
