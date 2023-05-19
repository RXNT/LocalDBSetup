SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Sheik
Create date			:	22-Jan-2020
Description			:	This procedure is used to validate logged in user doctor company
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [sch].[usp_ValidateLoggedInUserDoctorCompany]
(
	@LoggedInUserId				BIGINT,
	@DoctorCompanyId			BIGINT
)
AS
BEGIN	
	DECLARE @IsValid AS BIT

	SET @IsValid = 0

	SELECT	@IsValid = ISNULL(COUNT(*), 0)
	FROM	[dbo].[RsynRxNTMasterLogins] LG WITH (NOLOCK) 
	WHERE	LG.LoginId = @LoggedInUserId AND 
			LG.CompanyId = @DoctorCompanyId

	IF @IsValid = 0
	BEGIN
		select	@IsValid = ISNULL(COUNT(*), 0) 
		From	[dbo].[RsynSchedulerV2vwAppLogins]  WITH (NOLOCK)
		where	LoginId = @LoggedInUserId
				AND SiteAppRoleId in
				(select SiteAppRoleId 
				 From	scl.SiteAppRoles WITH (NOLOCK)
				 where	MasterAppRoleId in 
				(SELECT MasterAppRoleId From [dbo].[RsynSchedulerV2MasterAppRoles] WITH (NOLOCK) where IsSystemRole = 1)
		)
	END

	IF @IsValid = 0
	BEGIN
		RAISERROR (N'User Id (%I64d) and Doctor company Id (%I64d) mismatched.',
					18, -- Severity.
					1, -- State.
					@LoggedInUserId, -- First substitution argument.
					@DoctorCompanyId);
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
