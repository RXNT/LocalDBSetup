SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateDataExportLastRunStatus]
(
	@DataExportSettingId BIGINT,
	@DoctorCompanyId BIGINT,
	@DoctorId BIGINT,
	@LastRunDate DateTime,
	@LastRunStatus VARCHAR(5),
	@LastRunStatusMessage VARCHAR(2000),
	@BatchName VARCHAR(500)
)
AS
BEGIN
	DECLARE @StatusId As BIGINT

	SELECT	@StatusId = ApplicationTableConstantId 
	FROM	ehr.ApplicationTableConstants ATC WITH (NOLOCK)
			INNER JOIN ehr.ApplicationTables ATB WITH (NOLOCK) ON ATB.ApplicationTableId = ATC.ApplicationTableId
	WHERE	ATB.Code = 'STATP' AND ATC.Code = @LastRunStatus

	UPDATE	dbo.DataExportSettings
	SET		LastRunStatusId = @StatusId,
			LastRunDate = @LastRunDate,
			ModifiedBy = @DoctorId,
			ModifiedDate = @LastRunDate
	Where	DataExportSettingId = @DataExportSettingId
			AND DoctorCompanyId = @DoctorCompanyId

	INSERT INTO [dbo].[DataExportHistory]
		([DataExportSettingId], [DoctorCompanyId], [StatusId], [StatusMessage], [BatchName], [Active], [CreatedDate], [CreatedBy])
	VALUES
		(@DataExportSettingId, @DoctorCompanyId, @StatusId, @LastRunStatusMessage, @BatchName, 1, @LastRunDate, @DoctorId)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
