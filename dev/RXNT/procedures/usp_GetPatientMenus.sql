SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 10-May-2016
-- Description:	Get Patient Menus for doctor company
-- =============================================

CREATE PROCEDURE [dbo].[usp_GetPatientMenus] 
	@DoctorCompanyId BIGINT,
	@DoctorId BIGINT,
	@IsEHR BIT,
	@IsErx BIT
AS
BEGIN
	DECLARE @ShowVitals Varchar(5)=NULL
	IF EXISTS(SELECT * FROM doc_companies WHERE dc_id = @DoctorCompanyId AND EnableExternalVitals =1)
	BEGIN
		Set @ShowVitals = 'VITCH'
	END
	IF EXISTS(SELECT 1 FROM patient_menu_doctor_level WITH(NOLOCK)  WHERE dc_id = @DoctorCompanyId AND dr_id=@DoctorId)
	BEGIN
		SELECT pm.patient_menu_doctor_level_id patient_menu_id,
			pm.patient_menu_doctor_level_id test
			,pm.dc_id
			,'is_show' = 
			 CASE WHEN pm.patient_menu_doctor_level_id IS NULL
				  THEN (CASE
						 WHEN @IsEHR = 1 THEN mpm.is_ehr
						 WHEN @IsErx = 1 AND @ShowVitals IS NOT NULL THEN 1
						 WHEN @IsErx = 1 THEN mpm.is_erx
						 ELSE pm.is_show END) 
				  ELSE pm.is_show
			 END
			,pm.active
			,pm.created_date
			,ISNULL(pm.sort_order,mpm.sort_order) as 'sort_order'
			,mpm.master_patient_menu_id
			,mpm.code
			,mpm.description
			,mpm.is_ehr
			,mpm.is_erx
		FROM patient_menu_doctor_level pm
		RIGHT JOIN master_patient_menu mpm ON mpm.master_patient_menu_id = pm.master_patient_menu_id AND mpm.active = 1 AND pm.dc_id = @DoctorCompanyId AND pm.dr_id=@DoctorId
		WHERE ((@IsEHR = 1 AND mpm.is_ehr = @IsEHR) OR (@IsErx = 1 AND mpm.is_erx = @IsErx) OR (@ShowVitals IS NOT NULL AND mpm.code = @ShowVitals)) AND mpm.active = 1 AND mpm.code Not In ('TDAPP')
		ORDER BY sort_order
	END 
		ELSE 
			BEGIN 
				SELECT pm.patient_menu_id
					,pm.dc_id
					,'is_show' = 
					 CASE WHEN pm.patient_menu_id IS NULL
						  THEN (CASE
								 WHEN @IsEHR = 1 THEN mpm.is_ehr
								 WHEN @IsErx = 1 AND @ShowVitals IS NOT NULL THEN 1
								 WHEN @IsErx = 1 THEN mpm.is_erx
								 ELSE pm.is_show END) 
						  ELSE pm.is_show
					 END
					,pm.active
					,pm.created_date
					,ISNULL(pm.sort_order,mpm.sort_order) as 'sort_order'
					,mpm.master_patient_menu_id
					,mpm.code
					,mpm.description
					,mpm.is_ehr
					,mpm.is_erx
				FROM patient_menu pm
				RIGHT JOIN master_patient_menu mpm ON mpm.master_patient_menu_id = pm.master_patient_menu_id AND mpm.active = 1 AND pm.dc_id = @DoctorCompanyId
				WHERE ((@IsEHR = 1 AND mpm.is_ehr = @IsEHR) OR (@IsErx = 1 AND mpm.is_erx = @IsErx) OR (@ShowVitals IS NOT NULL AND mpm.code = @ShowVitals)) AND mpm.active = 1 AND mpm.code Not In ('TDAPP')
				ORDER BY sort_order
		END 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
