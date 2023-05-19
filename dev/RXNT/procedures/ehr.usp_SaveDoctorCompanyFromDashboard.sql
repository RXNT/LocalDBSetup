SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Stored Procedure

-- =============================================
-- Author:		JahabarYusuff
-- Create date: 14-Dec-2019
-- Description:	to save & Update Doctor Company From Dashboard projcet
-- =============================================

CREATE PROCEDURE [ehr].[usp_SaveDoctorCompanyFromDashboard]
(
	@DoctorCompanyId			BIGINT OUTPUT,

	@LoggedInUserId				BIGINT,
	@Concurrency				TIMESTAMP = NULL,
	@ConcurrencyErr				BIT OUTPUT,
	@AppConfigurationXML		XML,
	@EligibilityProviders		XML = NULL
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @XAppConfigId	BIGINT,
			@XAppValId		BIGINT;		
	SET @ConcurrencyErr=0;		
	IF @ConcurrencyErr = 0
	BEGIN
		DECLARE PFCursor CURSOR LOCAL FAST_FORWARD FOR
				SELECT  A.S.value('(CompanyApplicationConfigurationId)[1]', 'BIGINT') AS 'CompanyApplicationConfigurationId',						
						A.S.value('(ApplicationConfiguration/ApplicationConfigurationId) [1]', 'BIGINT') AS 'ApplicationConfigurationId',
						A.S.value('(ConfigurationValueId)[1]', 'BIGINT') AS 'ConfigurationValueId'
				FROM @AppConfigurationXML.nodes('ArrayOfCompanyApplicationConfiguration/CompanyApplicationConfiguration') A(S);	
		-- processing using Cursor					
		DECLARE @CompanyApplicationConfigurationId BIGINT
		DECLARE @ApplicationConfigurationId BIGINT
		DECLARE @ConfigurationValueId BIGINT		
		OPEN PFCursor
		FETCH NEXT FROM PFCursor into @CompanyApplicationConfigurationId, @ApplicationConfigurationId, @ConfigurationValueId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF ISNULL(@CompanyApplicationConfigurationId,0)  = 0
			BEGIN 
				INSERT INTO [ehr].[CompanyApplicationConfiguration]
				([ApplicationConfigurationId], ConfigurationValueId,[Active],DoctorCompanyId,
				[CreatedDate], [CreatedBy])
			VALUES(@ApplicationConfigurationId,@ConfigurationValueId,1,@DoctorCompanyId,GETDATE(),@LoggedInUserId)	

			END
			ELSE
			BEGIN
					UPDATE	[ehr].[CompanyApplicationConfiguration]
					SET		[ConfigurationValueId]			=	@ConfigurationValueId,														
							ModifiedBy						=	@LoggedInUserId,
							ModifiedDate					=	GETDATE()							
					WHERE CompanyApplicationConfigurationId = @CompanyApplicationConfigurationId
							AND ApplicationConfigurationId = @ApplicationConfigurationId
							And DoctorCompanyId = @DoctorCompanyId										

			END	
			FETCH NEXT FROM PFCursor into @CompanyApplicationConfigurationId, @ApplicationConfigurationId, @ConfigurationValueId
		END
		CLOSE PFCursor
		DEALLOCATE PFCursor
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
