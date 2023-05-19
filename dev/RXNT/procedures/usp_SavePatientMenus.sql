SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 10-May-2016
-- Description:	Save & Update Patient Menus
-- =============================================

CREATE PROCEDURE [dbo].[usp_SavePatientMenus]
	@PatientMenuId BIGINT OUTPUT,
	@MasterPatientMenuId BIGINT,
	@DoctorCompanyId BIGINT,
	@IsShow BIT,
	@SortOrder BIGINT,
	@LoggedInUserId BIGINT,
	@DoctorId BIGINT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM patient_menu_doctor_level WITH(NOLOCK)  WHERE dc_id = @DoctorCompanyId AND dr_id=@DoctorId AND master_patient_menu_id=@MasterPatientMenuId)
	BEGIN
		UPDATE patient_menu_doctor_level
		SET is_show = @IsShow,
		    sort_order = @SortOrder
		WHERE master_patient_menu_id = @MasterPatientMenuId AND dc_id = @DoctorCompanyId AND dr_id=@DoctorId
	END
	ELSE
	BEGIN
		INSERT INTO patient_menu_doctor_level
		 (master_patient_menu_id, dc_id, is_show, sort_order,active, created_date, created_by, dr_id)
		 VALUES 
		 (@MasterPatientMenuId, @DoctorCompanyId, @IsShow, @SortOrder,1, GETDATE(), @LoggedInUserId,@DoctorId)
		 
		 SET @PatientMenuId = SCOPE_IDENTITY();
	END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
