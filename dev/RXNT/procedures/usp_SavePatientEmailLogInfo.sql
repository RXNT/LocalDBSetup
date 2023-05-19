SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	05-SEPT-2018
Description			:	This procedure is used to Save Patient Email Log Info
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [dbo].[usp_SavePatientEmailLogInfo]
	@DoctorCompanyId			BIGINT,
	@PatientId					BIGINT,
	@Type						VARCHAR(10),
	@Token						VARCHAR(900),
	@LoggedInUserId				BIGINT,
	@ApplicationName			VARCHAR(30) = NULL,
	@Status						BIT = 1,
	@StatusMessage				VARCHAR(255) = NULL,
	@TokenExpiryDuration		INT=24,
	@PatientRepresentativeId	BIGINT = NULL 
AS
BEGIN
	IF (ISNULL(@DoctorCompanyId,0) > 0 AND ISNULL(@PatientId,0) > 0)
	BEGIN
		DECLARE @EmailTypeId AS BIGINT=0
		DECLARE @PatientEmailLogId AS BIGINT=NULL
		DECLARE @ApplicationId AS INT = 0
		
		IF (@ApplicationName IS NOT NULL)
		BEGIN
			SELECT TOP 1 @ApplicationId=ISNULL(ApplicationID,0) FROM dbo.Applications WITH(NOLOCK) WHERE Name = @ApplicationName
		END
		
		SELECT TOP 1 @EmailTypeId=ISNULL(ATC.ApplicationTableConstantId,0) FROM [ehr].[ApplicationTableConstants] ATC WITH(NOLOCK)
		INNER JOIN [ehr].[ApplicationTables] AT WITH(NOLOCK) ON ATC.ApplicationTableId=AT.ApplicationTableId
		WHERE AT.Code='PMTYP' AND ATC.Code=@Type
		
		IF (ISNULL(@EmailTypeId,0) > 0)
		BEGIN
			UPDATE [phr].[PatientEmailLogs]
			SET Active=0
			WHERE Type=@EmailTypeId AND
			PatientId=@PatientId AND
			DoctorCompanyId=@DoctorCompanyId AND
			ISNULL(PatientRepresentativeId,0)=ISNULL(@PatientRepresentativeId,0)
			
			INSERT INTO [phr].[PatientEmailLogs]
			(DoctorCompanyId, PatientId, Type, Token, TokenExpiryDate, Active, Status, StatusMessage, ApplicationId, CreatedDate, CreatedBy,PatientRepresentativeId)
			VALUES (@DoctorCompanyId, @PatientId, @EmailTypeId, @Token, DATEADD(HOUR, @TokenExpiryDuration, GETDATE()), 1, @Status, @StatusMessage,@ApplicationId, GETDATE(), @LoggedInUserId,@PatientRepresentativeId)
			
			SET @PatientEmailLogId = SCOPE_IDENTITY();
		END
		SELECT @PatientEmailLogId AS PatientEmailLogId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
