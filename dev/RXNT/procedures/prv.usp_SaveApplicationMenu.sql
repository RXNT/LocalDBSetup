SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 10-May-2016
-- Description:	Save & Update Patient Menus
-- =============================================

CREATE PROCEDURE [prv].[usp_SaveApplicationMenu]
	@ApplicationMenuId BIGINT OUTPUT,
	@MasterApplicationMenuId BIGINT,
	@DoctorCompanyId BIGINT,
	@IsShow BIT,
	@SortOrder BIGINT,
	@LoggedInUserId BIGINT
AS
BEGIN

	IF ISNULL(@ApplicationMenuId,0) = 0
	BEGIN
		INSERT INTO patient_menu
		 (master_patient_menu_id, dc_id, is_show, sort_order,active, created_date, created_by)
		 VALUES 
		 (@MasterApplicationMenuId, @DoctorCompanyId, @IsShow, @SortOrder,1, GETDATE(), @LoggedInUserId)
		 
		 SET @ApplicationMenuId = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE patient_menu
		SET is_show = @IsShow,
		    sort_order = @SortOrder
		WHERE patient_menu_id = @ApplicationMenuId AND dc_id = @DoctorCompanyId 
	END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
