SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ===========================
-- Author:		Singaravelan
-- Create date: 2-Aug-2016
-- Description:	To Get Vaccine By Id
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetVaccineById]
	@VaccineId INT
AS
BEGIN
SELECT b.vac_id,b.vac_name,b.CVX_CODE,b.dc_id,b.vac_exp_code, G.vac_group_name as vac_base_name, M.manufacturer_name as manufacturer,b.mvx_code,b.type,b.comments ,b.route,b.route_code,b.info_link, b.Expiration_Date, b.is_CDC_Active 
 FROM [dbo].[tblVaccines] b  
 inner join  tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code
 inner join tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
 Inner Join tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
 Inner JOIN tblVaccineManufacturers M ON b.manufacturer_Id=M.manufacturer_Id
 WHERE [vac_id]=@VaccineId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
