SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: 21-NOV-2017
-- Description:	To save the doctor manage ccd view preferences
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveDoctorManageCCDViewPreferences]  
	@DoctorId BIGINT,
	@DoctorCompanyId BIGINT,
	@DoctorManageCCDViewPreferenceId BIGINT,
	@LoggedInUserId BIGINT,
	@ManangeCCDViewDataId BIGINT,
	@DisplayOrder INT,
	@IsViewable BIT
AS

BEGIN
	SET NOCOUNT ON;
	
	IF ISNULL(@DoctorManageCCDViewPreferenceId, 0)  > 0
	BEGIN
		Update	[ehr].[DoctorManageCCDViewPreferences]
		SET		IsViewable = @IsViewable,
				DisplayOrder = @DisplayOrder,
				ModifiedBy = @LoggedInUserId,
				ModifiedDate = GETDATE()
		WHERE	DoctorId = @DoctorId
				AND DoctorCompanyId = @DoctorCompanyId
				AND DoctorManageCCDViewPreferenceId = @DoctorManageCCDViewPreferenceId
	END
	ELSE 
	BEGIN
		INSERT INTO [ehr].[DoctorManageCCDViewPreferences]
		(DoctorId, DoctorCompanyId, ManageCCDViewDataId, IsViewable, DisplayOrder, Active, CreatedBy, CreatedDate)
		Values(@DoctorId, @DoctorCompanyId, @ManangeCCDViewDataId, @IsViewable, @DisplayOrder, 1, @LoggedInUserId, GETDATE())
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
