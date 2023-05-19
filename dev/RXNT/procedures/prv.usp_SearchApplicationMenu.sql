SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 09-SEP-2016
-- Description:	Saerch Application Menu
-- =============================================

CREATE PROCEDURE [prv].[usp_SearchApplicationMenu]
	@DoctorCompanyId	BIGINT,
	@DoctorId			BIGINT,
	@UserId				BIGINT,
	@IsEHR				BIT = NULL,
	@IsErx				BIT = NULL,
	@IsActive			BIT = NULL
AS
BEGIN
	SET @IsEHR=ISNULL(@IsEHR,1)
	SET @IsErx=ISNULL(@IsErx,1)
	SELECT pm.patient_menu_id
		,pm.dc_id
		,'is_show' = 
		 CASE WHEN pm.patient_menu_id IS NULL
		      THEN (CASE
		             WHEN @IsEHR = 1 THEN mpm.is_ehr
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
	WHERE ( mpm.is_ehr = @IsEHR OR mpm.is_erx = @IsErx) AND (@IsActive IS NULL OR  mpm.active = @IsActive)
		AND mpm.code in ('MEDIC', 'REFER', 'LABSS', 'ENCTR','FMAIL', 'PTDOC','TDAPP')
	ORDER BY sort_order
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
