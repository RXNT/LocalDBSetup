SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Afsal Y
-- Create date: 31-Jul-2017
-- Description:	To Search Patient favourite Pharmacies
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchPatientFavPharmacies]
	@PatientId BIGINT
AS
BEGIN
	SELECT P.PHARM_ID,P.SERVICE_LEVEL, P.PHARM_COMPANY_NAME, P.PHARM_ADDRESS1, P.PHARM_ADDRESS2, P.PHARM_CITY, P.PHARM_STATE, P.PHARM_ZIP, P.PHARM_PHONE, P.NCPDP_NUMB, P.PHARM_FAX, P.PHARM_PARTICIPANT,
		
		CASE WHEN x.pharmacy_id IS null THEN 0 ELSE 1 END MO
		FROM PHARMACIES P 
		left outer join pharm_mo_xref X on p.pharm_id = X.pharmacy_id 
		INNER JOIN PATIENTS_FAV_PHARMS PH ON P.PHARM_ID = PH.PHARM_ID 
		WHERE P.PHARM_ENABLED = 1 AND PH.PA_ID = @PatientId  
		ORDER BY pharm_use_date DESC, pharm_participant DESC, pharm_state, pharm_city, pharm_company_name, pharm_address1;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
