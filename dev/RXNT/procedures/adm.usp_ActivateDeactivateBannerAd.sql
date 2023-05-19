SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Afsal Y 
Create date			: 14-April-2017
Description			: Activate or deactivate a Banner
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [adm].[usp_ActivateDeactivateBannerAd] 
	@BannerAdIds XML   ,
	@Active   VARCHAR(80),
	@LoggedInUserId  INT 
	
	
AS

BEGIN
 SET NOCOUNT ON;

 IF ISNULL(@Active,1) = 1 
 BEGIN
    UPDATE dbo.rxnt_sg_promotions SET Active = 1, iscomplete = 0
     WHERE ad_id IN (
     SELECT SGP.ad_id FROM
	(SELECT t.value('.', 'VARCHAR(10)') AS PromotionId
		FROM @BannerAdIds.nodes('ArrayOfLong/long') as x(t)) t1
        INNER JOIN	dbo.rxnt_sg_promotions SGP WITH(NOLOCK)
	    ON t1.PromotionId = SGP.ad_id)
 END

 ELSE
 BEGIN
   UPDATE dbo.rxnt_sg_promotions SET Active = 0,  iscomplete = 1, InactivatedDate = GETDATE(), InactivatedBy = @LoggedInUserId
     WHERE ad_id IN (
     SELECT SGP.ad_id FROM
	(SELECT t.value('.', 'VARCHAR(10)') AS PromotionId
		FROM @BannerAdIds.nodes('ArrayOfLong/long') as x(t)) t1
        INNER JOIN	dbo.rxnt_sg_promotions SGP WITH(NOLOCK)
	    ON t1.PromotionId = SGP.ad_id)
 END
 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
