SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 03-Sep-2016
-- Description:	Search Paient Immunizations Meta Data
-- Modified By: Reiah Paul Sam
-- Description:search patient Immunization records with deleted records, deleted by and date 
	-- Order by is modified as per the ticket V1QA-357
-- Modified Date: 06-Oct-2017
-- =============================================
CREATE   PROCEDURE [ehr].[usp_SearchPatientImmunizationMetaData]
	@PatientId BIGINT,
	@MaxRows INT,
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN
	SELECT  a.vac_rec_id, 
			a.vac_dt_admin, 
			ISNULL(G.vac_group_name,b.vac_base_name) as vac_base_name,
			isnull(a.active, 1) as immunization_active_status,
			d.dr_first_name as immunization_dr_fname,
			d.dr_last_name  as immunization_dr_lname,
			a.[last_modified_date] as immunization_deleted_on, 
			VGM.vac_group_id,
			VISM_O.vis_edition_date as vis_edition_date,
			b.comments as vaccine_comment,
			b.CVX_CODE,
			NDC.NDC11
	FROM tblVaccinationRecord a WITH(NOLOCK)
	INNER JOIN tblvaccines b WITH(NOLOCK) on a.vac_id= b.vac_id 
	LEFT OUTER JOIN tblvaccineCVX CVX WITH(NOLOCK) ON b.CVX_CODE=CVX.cvx_code
	LEFT OUTER JOIN (SELECT *, ROW_NUMBER() OVER(PARTITION BY [CVXCode] ORDER BY [is_active] DESC, [last_updated_date] DESC, [NDC11] DESC, [GTIN] DESC) AS [row_number]
					 FROM [RxNT].[dbo].[tblVaccineCVXToVaccineNDCMappings]) NDC ON b.CVX_CODE = NDC.CVXCode AND NDC.[row_number] = 1
	LEFT OUTER JOIN tblVaccineCVXToVaccineGroupsMappings VGM WITH(NOLOCK) ON VGM.cvx_id=CVX.cvx_id 
	LEFT OUTER JOIN (SELECT  VISM.cvx_id,
						     MAX(VIS.vis_edition_date) vis_edition_date
					 FROM tblVaccineCVXToVISMappings VISM WITH(NOLOCK) 
					 INNER JOIN tblVaccineVIS VIS WITH(NOLOCK) ON VIS.vis_concept_id=VISM.vis_concept_id  
					 INNER JOIN tblvaccines tv WITH(NOLOCK) ON VISM.cvx_id=tv.cvx_id
					 INNER JOIN tblVaccinationRecord tvd  WITH(NOLOCK) ON tv.vac_id=tvd.vac_id
					 WHERE tvd.vac_pat_id=@PatientId AND VIS.vis_edition_date<=tvd.vac_dt_admin
					 GROUP BY VISM.cvx_id) AS VISM_O ON  CVX.cvx_id=VISM_O.cvx_id  
	LEFT OUTER JOIN tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
	LEFT OUTER JOIN doctors d with(nolock) On d.dr_id=a.last_modified_by
	WHERE vac_pat_id = @PatientId
	AND (a.vac_dt_admin >=@StartDate  OR @StartDate IS NULL) 
	AND (a.vac_dt_admin <=@EndDate OR @EndDate IS NULL)	
	ORDER BY VAC_DT_ADMIN DESC;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
