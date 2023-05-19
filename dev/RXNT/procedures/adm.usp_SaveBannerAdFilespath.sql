SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Afsal Y
-- Create date: 06-APRIL-2017
-- Description:	Save Or Update Promotion
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveBannerAdFilespath]
	@BannerAdId		INT,
	@FilesPath	VARCHAR(80) = NULL
	
	
AS

BEGIN
	UPDATE dbo.rxnt_sg_promotions
	
	SET resource_path	= @FilesPath
		
    WHERE ad_id = @BannerAdId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
