SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: JUNE 06, 2018
-- Description:	Search Doctor Favorite Pharmacies
-- =============================================
CREATE PROCEDURE [dbo].[SearchDoctorFavoritePharmacies]
(
	-- Add the parameters for the stored procedure here,
	@DoctorGroupId		BIGINT,
	@DoctorId			BIGINT
)
AS
BEGIN
	SELECT P.PHARM_ID, P.SERVICE_LEVEL,P.PHARM_COMPANY_NAME, P.PHARM_ADDRESS1, P.PHARM_ADDRESS2, P.PHARM_CITY, P.PHARM_STATE, 
	P.PHARM_ZIP, P.PHARM_PHONE, P.NCPDP_NUMB, P.PHARM_FAX, P.PHARM_PARTICIPANT, CASE WHEN x.pharmacy_id IS null THEN 0 ELSE 1 END MO
	FROM PHARMACIES P WITH(NOLOCK) 
	LEFT OUTER JOIN pharm_mo_xref X WITH(NOLOCK) ON p.pharm_id = X.pharmacy_id
	INNER JOIN doc_site_fav_pharms DH WITH(NOLOCK) ON P.PHARM_ID = DH.PHARM_ID 
	WHERE P.PHARM_ENABLED = 1 AND DH.DR_ID = @DoctorId
	UNION
	SELECT P.PHARM_ID, P.SERVICE_LEVEL,P.PHARM_COMPANY_NAME, P.PHARM_ADDRESS1, P.PHARM_ADDRESS2, P.PHARM_CITY, P.PHARM_STATE, 
	P.PHARM_ZIP, P.PHARM_PHONE, P.NCPDP_NUMB, P.PHARM_FAX, P.PHARM_PARTICIPANT, CASE WHEN x.pharmacy_id IS null THEN 0 ELSE 1 END MO
	FROM PHARMACIES P WITH(NOLOCK) 
	LEFT OUTER JOIN pharm_mo_xref X WITH(NOLOCK) ON p.pharm_id = X.pharmacy_id
	INNER JOIN doc_group_fav_pharms DGFP WITH(NOLOCK) ON P.PHARM_ID = DGFP.PHARM_ID 
	WHERE P.PHARM_ENABLED = 1 AND DGFP.DG_ID = @DoctorGroupId
	ORDER BY pharm_company_name, pharm_participant DESC, pharm_state, pharm_city , pharm_address1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
