SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: JUNE 08, 2018
-- Description:	Search Doctor Group Favorite Referral Institution
-- =============================================
CREATE PROCEDURE [dbo].[SearchDoctorGroupFavoriteInstitutions] 
(
	@DoctorGroupId		BIGINT
)
AS
BEGIN
	SELECT 
	   ref.inst_id as InstitutionId,
	   ref.inst_name as InstitutionName
	FROM referral_institutions ref 
	INNER JOIN doc_group_fav_ref_institutions DGP  WITH(NOLOCK) ON ref.inst_id = DGP.inst_id 
	WHERE DGP.DG_ID = @DoctorGroupId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
