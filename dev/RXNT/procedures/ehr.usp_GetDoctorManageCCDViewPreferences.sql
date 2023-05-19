SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: 21-NOV-2017
-- Description:	To get the doctor manage ccd view preferences
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetDoctorManageCCDViewPreferences]  
	@DoctorId BIGINT,
	@DoctorCompanyId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	
	Select	ATC.*, CASE WHEN SP.IsViewable IS NULL THEN 0 ELSE SP.IsViewable END IsViewable, 
			CASE WHEN SP.DisplayOrder IS NULL THEN ATC.SortOrder ELSE SP.DisplayOrder END DisplayOrder,
			SP.DoctorManageCCDViewPreferenceId, SP.Active As PreferenceActive, SC.Code As LoincCode,
			CASE WHEN SP.DoctorManageCCDViewPreferenceId IS NULL THEN 0
				ELSE SP.DoctorManageCCDViewPreferenceId 
				END DoctorManageCCDViewPreferenceId,
				ATC.ApplicationTableConstantId ManangeCCDViewDataId, 
				@DoctorId as  DoctorId, 
				@DoctorCompanyId  as DoctorCompanyId
	From	ehr.ApplicationTableConstants ATC WITH (NOLOCK)
			INNER JOIN ehr.ApplicationTables AT WITH (NOLOCK) on AT.ApplicationTableId = ATC.ApplicationTableId and AT.Code = 'MCCDV'
			INNER JOIN ehr.SysLookupCodeSystem SCS WITH (NOLOCK) on SCS.ApplicationTableCode = AT.Code
			INNER JOIN ehr.SysLookupCodes SC WITH (NOLOCK) on SC.CodeSystemId = SCS.CodeSystemId AND SC.ApplicationTableConstantCode = ATC.Code
			LEFT JOIN [ehr].[DoctorManageCCDViewPreferences] SP WITH (NOLOCK) on SP.ManageCCDViewDataId = ATC.ApplicationTableConstantId 
						and SP.Doctorid = @DoctorId
						and SP.DoctorCompanyId = @DoctorCompanyId
	where   ATC.Active = 1
			Order By CASE WHEN SP.DisplayOrder IS NULL THEN ATC.SortOrder ELSE SP.DisplayOrder END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
