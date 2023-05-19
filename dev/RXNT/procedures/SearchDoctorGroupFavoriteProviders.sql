SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: JUNE 08, 2018
-- Description:	Search Doctor Group Favorite Providers
-- =============================================
CREATE PROCEDURE [dbo].[SearchDoctorGroupFavoriteProviders]
(
	@DoctorGroupId		BIGINT
)
AS
BEGIN
	SELECT 
	   ref.target_dr_id,
	   ref.[first_name]
      ,ref.[last_name]
      ,ref.[middle_initial]
      ,ref.[GroupName]
      ,ref.[speciality]
      ,ref.[address1]
      ,ref.[city]
      ,ref.[state]
      ,ref.[zip]
      ,ref.[phone]
      ,ref.[fax]
      ,ref.[IsLocal]
      ,ref.[dc_id]
      ,ref.[direct_email]
      ,ref.[MasterContactId]
      ,ref.[ModifiedDate]
      ,ref.[address2]
	FROM referral_target_docs ref INNER JOIN doc_group_fav_ref_providers DGP  WITH(NOLOCK) ON ref.target_dr_id = DGP.target_dr_id 
	WHERE DGP.DG_ID = @DoctorGroupId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
