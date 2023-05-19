SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 2-Aug-2016
-- Description:	To search the vaccines
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchVaccines]
	@Name VARCHAR(50),
	@MaxRows INT = 50,
	@MainDoctorCompanyId INT
AS
BEGIN
 
--select TOP (@MaxRows) vac_id, vac_name, vac_base_name, cvx_code 
--from (
--select vac_id, vac_name, vac_base_name, cvx_code from tblVaccines where dc_id = 0 
--union 
--select vac_id, vac_name, vac_base_name, cvx_code from tblVaccines where dc_id = @MainDoctorCompanyId
--) S  where (vac_name like '%'+@Name+'%' or vac_base_name like '%'+@Name+'%' OR cvx_code like '%'+@Name+'%')  order by vac_name

select TOP (@MaxRows) vac_id, vac_name, manufacturer_name, vac_group_name,  cvx_name_short, is_CDC_Active 
from (

select V.vac_id,V.vac_name, M.manufacturer_name, G.vac_group_name, CVX.cvx_name_short, V.is_CDC_Active  from tblVaccines V
inner join  tblvaccineCVX CVX ON V.CVX_CODE=CVX.cvx_code
inner join tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
Inner Join tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
Inner JOIN tblVaccineManufacturers M ON V.manufacturer_Id=M.manufacturer_Id
where V.dc_id = 0  AND V.is_CDC_Active IS NOT NULL

) S  where (vac_group_name like '%'+@Name+'%' OR cvx_name_short like '%'+@Name+'%' or vac_name like '%'+@Name+'%')  order by vac_name



END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
