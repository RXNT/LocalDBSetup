SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 12-Oct-2016
-- Description:	To Search Favourite Providers
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_SearchFavouriteProviders]
  @MainDoctorId INT,
  @DoctorCompanyId BIGINT 
AS
BEGIN

	SELECT R.[target_dr_id],[first_name],[last_name],[middle_initial],[GroupName],[speciality],[address1],[city],[state],[zip],[phone],[fax],[IsLocal],[ext_doc_id],'' suffix , [address2]
	FROM [referral_target_docs] R WITH(NOLOCK)
	inner join referral_fav_providers S WITH(NOLOCK)
	ON R.target_dr_id = S.target_dr_id 
	where s.main_dr_id = @MainDoctorId AND R.dc_id=@DoctorCompanyId  
	order by last_name,first_name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
