SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author                : Nambi
Create date            : 18-APR-2022
Description            : Disable banner ads for users in the list of companies
Last Modified By    : 
Last Modifed Date    : 
======================================================================================= 
*/ 
CREATE PROCEDURE [adm].[usp_DisableBannerAdsForUsersInCompanies]
AS

    UPDATE DI SET is_bannerads_enabled = 0 
    FROM doctor_info DI WITH(NOLOCK)
    INNER JOIN doctors DR WITH(NOLOCK) ON DI.dr_id = DR.dr_id
    INNER JOIN doc_groups DG WITH(NOLOCK) ON DR.dg_id = DG.dg_id
    INNER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id = DC.dc_id 
    WHERE DC.dc_id IN (31502) AND  (DI.is_bannerads_enabled is null OR DI.is_bannerads_enabled = 1) AND DR.dr_enabled = 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
