SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	20-NOV-2017
-- Description:		Get Vaccine Detail by CVX Code
-- =============================================
CREATE PROCEDURE [ehr].[GetVaccineDetailsByCVXCode]
  @CVXCode			VARCHAR(30)
AS
BEGIN
	SELECT TOP 1 b.vac_id
	FROM tblvaccines b 
	INNER JOIN  tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code
	INNER JOIN tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
	INNER JOIN tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
	INNER JOIN tblVaccineManufacturers M ON b.manufacturer_Id=M.manufacturer_Id
	WHERE CVX.cvx_code=@CVXCode AND b.is_CDC_Active IS NOT NULL AND b.dc_id=0
	ORDER BY b.is_CDC_Active DESC,b.is_active DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
