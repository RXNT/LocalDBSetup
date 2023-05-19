SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 4/3/2018
-- Description:	To get the patient diagnosis
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [rules].[usp_SearchPatientImmunization]
	@PatientId BIGINT
AS
BEGIN
	SELECT a.vac_rec_id, a.vac_dt_admin, G.vac_group_name as vac_base_name,b.vac_name
	,isnull(a.active, 1) as immunization_active_status
	  ,d.dr_first_name as immunization_dr_fname,d.dr_last_name  as immunization_dr_lname,
	  a.[last_modified_date] as immunization_deleted_on, VGM.vac_group_id
	FROM tblVaccinationRecord a WITH(NOLOCK)
	INNER JOIN tblvaccines b WITH(NOLOCK) on a.vac_id= b.vac_id 
	inner join  tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code
	inner join tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
	Inner Join tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
	Left Outer Join doctors d with(nolock) On d.dr_id=a.last_modified_by
	WHERE vac_pat_id = @PatientId 
	--AND (a.vac_dt_admin >=@StartDate  OR @StartDate IS NULL) AND (a.vac_dt_admin <=@EndDate OR @EndDate IS NULL) 
	order by VAC_DT_ADMIN DESC;
	--order by b.vac_base_name ASC,a.vac_name ASC,VAC_DT_ADMIN ASC; old Line
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
