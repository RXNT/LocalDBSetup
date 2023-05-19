SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: JUNE 08, 2018
-- Description:	Search Doctor Group Favorite Pharmacies
-- =============================================
CREATE PROCEDURE [dbo].[SearchDoctorGroupFavoritePharmacies]
(
	@DoctorGroupId		BIGINT
)
AS
BEGIN
	SELECT 
		P.PHARM_ID, 
		P.SERVICE_LEVEL,
		P.PHARM_COMPANY_NAME, 
		P.PHARM_ADDRESS1, 
		P.PHARM_ADDRESS2, 
		P.PHARM_CITY, 
		P.PHARM_STATE, 
		P.PHARM_ZIP, 
		P.PHARM_PHONE, 
		P.NCPDP_NUMB,
		P.PHARM_FAX, 
		P.PHARM_PARTICIPANT, 
		CASE WHEN x.pharmacy_id IS null THEN 0 ELSE 1 END MO
	FROM PHARMACIES P WITH(NOLOCK) 
	LEFT OUTER JOIN pharm_mo_xref X WITH(NOLOCK) ON p.pharm_id = X.pharmacy_id
	INNER JOIN doc_group_fav_pharms DGP WITH(NOLOCK) ON P.PHARM_ID = DGP.PHARM_ID 
	WHERE P.PHARM_ENABLED = 1 AND DGP.DG_ID = @DoctorGroupId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
