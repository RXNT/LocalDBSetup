SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Afsal Y
-- Create date: 06-APRIL-2017
-- Description:	Save Or Update Promotion
-- =============================================
CREATE PROCEDURE [adm].[usp_GetBannerAd] 
	@BannerAdId INT
AS 
BEGIN 
	SET NOCOUNT ON; 
	
	SELECT	ad_id,
			name,
			session_count,
			medid,
			med_name,
			dtStart,
			current_count,
			increments,
			dtEnd,
			state_exclusion,
			min_age,
			iscomplete,
			max_age,
			gender,
			Active,
			ctrl_fac,
			message,
			type,
			speciality_1,
			speciality_2,
			speciality_3,
			url,
			resource_path,
			TargetedPlatform

	
	FROM dbo.rxnt_sg_promotions
	
	WHERE ad_id = @BannerAdId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
