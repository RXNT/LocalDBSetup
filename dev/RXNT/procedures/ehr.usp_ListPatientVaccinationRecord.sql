SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	06-JUNE-2016
Description			:	This procedure is used to List Patient VaccinationRecord
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

 CREATE   PROCEDURE [ehr].[usp_ListPatientVaccinationRecord]
	@paid BIGINT,
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	SELECT DISTINCT VAC_REC_ID, 
					a.vac_name,
					a.action_code, 
					G.vac_group_name as vac_base_name,
					b.vac_name as vac_parent_name,
					vis_date, 
					vis_given_date, 
					a.VAC_ID, 
					VAC_PAT_ID, 
					VAC_DT_ADMIN, 
					VAC_LOT_NO, 
					VAC_SITE, 
					VAC_DOSE, 
					VAC_EXP_DATE, 
					VAC_DR_ID, 
					VAC_REACTION, 
					VAC_REMARKS,
					a.vac_site_code,
					a.vac_dose_unit_code,
					a.vac_administered_code,
					a.vac_administered_by,
					a.vac_entered_by,
					a.substance_refusal_reason_code,
					a.disease_code,
					a.vfc_code,
					M.manufacturer_name as manufacturer,a.route,
					b.cvx_code,
					NDC.NDC11,
					b.mvx_code,
					a.route_code,
					a.eligibility_category_code, 
					VIS.vis_edition_date, 
					a.active, 
					a.visibility_hidden_to_patient 
	 from tblVaccinationRecord a 
	 inner join tblvaccines b on a.vac_id= b.vac_id 
	 inner join  tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code 
	 inner join tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id 
	 Inner Join tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id 
	 Inner JOIN tblVaccineManufacturers M ON b.manufacturer_Id=M.manufacturer_Id 
	 LEFT OUTER JOIN tblVaccineCVXToVaccineNDCMappings NDC ON NDC.CVXCode = CVX.cvx_code and NDC.is_active =1 
	 Left Outer JOIN (SELECT cvx_id,MAX(VIS.vis_edition_date) AS vis_edition_date FROM tblVaccineCVXToVISMappings VISM 
	 INNER JOIN tblVaccineVIS VIS ON VISM.vis_concept_id=VIS.vis_concept_id and  VIS.Vis_edition_status='Current' 
	 GROUP BY cvx_id) VIS ON VIS.cvx_id=CVX.cvx_id where VAC_PAT_ID =@paid  AND 
	 (a.vac_dt_admin >=DATEADD(dd, 0, DATEDIFF(dd, 0, @StartDate)) 
	  OR @StartDate IS NULL) AND (a.vac_dt_admin <=DATEADD(ms,-3,DATEADD(DAY,1,DATEADD(dd, DATEDIFF(dd,0,@EndDate), 0))) 
	  OR @EndDate IS NULL) order by G.vac_group_name ASC,a.vac_name ASC,VAC_DT_ADMIN ASC 
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
