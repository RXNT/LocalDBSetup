SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 27-Apr-2016
-- Description:	For development purpose
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllPatientMenu]
AS
BEGIN
	SET NOCOUNT ON;

	  select master_patient_menu_id,code,description, sort_order, is_ehr, is_erx, created_date, created_by, modified_date, modified_by, inactivated_date, inactivated_by, active 
	  from master_patient_menu mpm WITH(NOLOCK)
	  ORDER BY mpm.sort_order ASC

	--SELECT *
	--FROM patient_menu pm
	--RIGHT JOIN master_patient_menu mpm ON mpm.master_patient_menu_id = pm.master_patient_menu_id

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
