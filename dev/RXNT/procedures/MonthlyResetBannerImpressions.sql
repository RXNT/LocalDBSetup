SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Shylaja	Chippa
-- Create date: 10/01/2013	
-- Description:	This store procedure takes a backup and resets monthly impression levels of all banners in our system. 
-- =============================================
CREATE PROCEDURE MonthlyResetBannerImpressions 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    	DECLARE @BackupImpressions VARCHAR(20), @ResetImpressions VARCHAR(20)
	SET @BackupImpressions = 'BackupImpressions'
	SET @ResetImpressions = 'ResetImpressions'

    BEGIN TRANSACTION @BackupImpressions;

		BEGIN TRY
			insert into rxnt_sg_promotions_count (ad_id,dtstart,dtEnd,total)
						select ad_id,DATEADD(MM,-1,GETDATE()),GETDATE(), current_count 
						from rxnt_sg_promotions 
						where medid=0;
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION @BackupImpressions;
			END
		END CATCH;

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION @BackupImpressions;
			
	IF @@TRANCOUNT = 0
	BEGIN	
		BEGIN TRANSACTION @ResetImpressions;
			BEGIN TRY
				update rxnt_sg_promotions set session_count =increments,current_count =0 where medid=0;
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
					ROLLBACK TRANSACTION @ResetImpressions;
			END CATCH;
		IF @@TRANCOUNT > 0
		COMMIT TRANSACTION @ResetImpressions;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
