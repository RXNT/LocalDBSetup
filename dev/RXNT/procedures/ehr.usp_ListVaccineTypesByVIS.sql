SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	06-DEC-2017
Description			:	This procedure is used to List VaccineTypes By VIS
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[usp_ListVaccineTypesByVIS]
	@vac_id BIGINT
	
AS
BEGIN
		SELECT DISTINCT VIS.cvx_id,VIS.vis_encoded_text,VIS.vis_concept_name FROM tblvaccines b WITH(NOLOCK)
		inner join  tblvaccineCVX CVX ON b.CVX_CODE = CVX.cvx_code 
		inner join tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id = CVX.cvx_id 
		Inner Join tblvaccineGroups G ON G.vac_group_id = VGM.vac_group_id 
		 LEFT Outer JOIN(SELECT cvx_id,VIS.vis_concept_id, MAX(VIS.vis_edition_date) AS vis_edition_date, VIS.vis_encoded_text, VIS.vis_concept_name FROM tblVaccineCVXToVISMappings VISM 
		INNER JOIN tblVaccineVIS VIS ON VISM.vis_concept_id = VIS.vis_concept_id And VISM.is_active = 1 And
		VIS.Vis_edition_status = 'Current' GROUP BY cvx_id, VIS.vis_encoded_text, VIS.vis_concept_id,VIS.vis_concept_name) VIS ON VIS.cvx_id = CVX.cvx_id 
		 WHERE b.vac_id = @vac_id 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
