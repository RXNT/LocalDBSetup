SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[CopyFavProviders] 
	-- Add the parameters for the stored procedure here
	@copyFromDr_id INTEGER,
	@copyToDr_id INTEGER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @target_dr_id INTEGER
    -- Insert statements for procedure here
    DECLARE dr_records CURSOR
	READ_ONLY
		FOR
			SELECT target_dr_id FROM referral_fav_providers WHERE main_dr_id = @copyFromDr_id			
	OPEN dr_records
	FETCH NEXT FROM dr_records INTO @target_dr_id
	WHILE (@@FETCH_STATUS <> -1)
    BEGIN
		INSERT INTO referral_fav_providers (main_dr_id, target_dr_id) VALUES(@copyToDr_id, @target_dr_id)
		FETCH NEXT FROM dr_records INTO @target_dr_id
    END
	CLOSE dr_records
	DEALLOCATE dr_records
	
	select * FROM referral_fav_providers WHERE main_dr_id = @copyToDr_id
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
