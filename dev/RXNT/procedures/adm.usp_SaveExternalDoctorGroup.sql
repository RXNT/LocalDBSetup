SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ============================================= 
-- Author		: Kanniyappn Narasiman 
-- Create date	: 15-Jun-2016
-- Description	: To save & Update Doctor Group 
-- ============================================= 
 
CREATE PROCEDURE [adm].[usp_SaveExternalDoctorGroup]
( 
	@DoctorGroupId		INT OUTPUT, 
	@DoctorCompanyId	INT,
	@Name				VARCHAR(80), 
	@ConcurrencyErr		BIT =0 OUTPUT,
	@LowUsageFlag		TINYINT=0,
	@LoggedInUserId		BIGINT=0
) 
AS 
BEGIN 
	SET NOCOUNT ON; 
		
	    SET @ConcurrencyErr=0; 
		IF ISNULL (@DoctorGroupId,0) =0 
		BEGIN
			
			INSERT INTO dbo.doc_groups
				(dc_id,
				dg_name,
				beta_tester) 
			VALUES 
				(@DoctorCompanyId, 
				@Name,
				1) 
	 
				SET @DoctorGroupId = SCOPE_IDENTITY();
	
		END	
		ELSE 
		BEGIN 
			SET @ConcurrencyErr=0; 
	 
			IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.doc_groups 
			WHERE dg_id = @DoctorGroupId) 
			BEGIN 
				SET @ConcurrencyErr=1; 
			END 
	 
			IF @ConcurrencyErr = 0 
			BEGIN 
				UPDATE dbo.doc_groups 
					SET dg_name		= @Name
					
				WHERE dg_id		= @DoctorGroupId 
			END
		END
		
		DELETE FROM [dbo].[DoctorGroupUsageFlags] WHERE DoctorGroupId=@DoctorGroupId
		
		DELETE DRU FROM doc_usage_flags DRU WITH(NOLOCK)
		INNER JOIN doctors DR WITH(NOLOCK) ON DRU.dr_id=DR.dr_id
		WHERE DR.dg_id=@DoctorGroupId
		
		IF (ISNULL(@LowUsageFlag,0) > 0 AND
		NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[DoctorGroupUsageFlags] WITH(NOLOCK) WHERE DoctorGroupId=@DoctorGroupId AND UsageFlags=@LowUsageFlag))
		BEGIN
			INSERT INTO [dbo].[DoctorGroupUsageFlags]
			(DoctorGroupId, UsageFlags, CreatedBy, CreatedDate)
			VALUES(@DoctorGroupId, @LowUsageFlag, @LoggedInUserId, GETDATE())
			
			INSERT INTO doc_usage_flags
			(dr_id, usage_flags)
			SELECT DR.dr_id, @LowUsageFlag
			FROM doc_groups DG WITH(NOLOCK)
			INNER JOIN doctors DR WITH(NOLOCK) ON DR.dg_id=DG.dg_id
			WHERE	DG.dg_id=@DoctorGroupId AND 
					DR.prescribing_authority>=3 AND
					DR.dr_enabled=1
		END 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
