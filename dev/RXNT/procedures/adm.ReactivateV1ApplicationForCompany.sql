SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 11-FEB-2021
-- Description:	ReactivateDoctorCompany
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [adm].[ReactivateV1ApplicationForCompany]
	@DoctorCompanyId	BIGINT,
	@EnableERXV1Module	BIT,
	@EnableEHRV1Module	BIT	
AS
BEGIN
	IF @EnableERXV1Module = 1 AND NOT EXISTS(SELECT TOP 1 1 FROM patient_menu pm WITH(NOLOCK) INNER JOIN master_patient_menu mpm WITH(NOLOCK) ON pm.master_patient_menu_id=mpm.master_patient_menu_id WHERE dc_id = @DoctorCompanyId AND mpm.is_erx=1)
	BEGIN
		INSERT INTO patient_menu (master_patient_menu_id, dc_id, is_show, sort_order,active, created_date, created_by) 
		SELECT mpm.master_patient_menu_id,@DoctorCompanyId,1,mpm.sort_order,1, GETDATE(),0 
		from master_patient_menu mpm  WITH(NOLOCK)
		LEFT OUTER JOIN patient_menu pm  WITH(NOLOCK) ON pm.master_patient_menu_id =mpm.master_patient_menu_id AND pm.dc_id = @DoctorCompanyId
		WHERE is_erx=1 AND pm.patient_menu_id IS NULL
		ORDER BY mpm.sort_order ASC
	END
		
	IF @EnableEHRV1Module = 1 AND NOT EXISTS(SELECT TOP 1 1 FROM patient_menu pm WITH(NOLOCK) INNER JOIN master_patient_menu mpm WITH(NOLOCK) ON pm.master_patient_menu_id=mpm.master_patient_menu_id WHERE dc_id = @DoctorCompanyId AND mpm.is_ehr=1 AND ISNULL(mpm.is_erx,0)=0)
	BEGIN
		INSERT INTO patient_menu (master_patient_menu_id, dc_id, is_show, sort_order,active, created_date, created_by) 
		SELECT mpm.master_patient_menu_id,@DoctorCompanyId,1,mpm.sort_order,1, GETDATE(),0 
		from master_patient_menu mpm  WITH(NOLOCK)
		LEFT OUTER JOIN patient_menu pm  WITH(NOLOCK) ON pm.master_patient_menu_id =mpm.master_patient_menu_id AND pm.dc_id = @DoctorCompanyId
		where is_ehr=1 AND pm.patient_menu_id IS NULL
		ORDER BY mpm.sort_order ASC
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
