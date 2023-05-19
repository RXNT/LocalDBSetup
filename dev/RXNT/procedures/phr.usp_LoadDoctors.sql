SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Save Access Log Entry
-- =============================================
CREATE PROCEDURE  [phr].[usp_LoadDoctors]

	@DoctorCompanyId	BIGINT
AS
BEGIN
	SELECT D.DR_FIRST_NAME,D.epcs_enabled,D.dr_enabled,loginlock, D.DR_PREFIX, D.DR_SUFFIX, 
	D.hipaa_agreement_acptd, D.dr_agreement_acptd, D.dr_def_rxcard_history_back_to,
	D.dr_rxcard_search_consent_type, D.dr_def_pat_history_back_to, 
	D.NPI, D.TIME_DIFFERENCE, D.DR_MIDDLE_INITIAL, D.DR_LAST_NAME,
	 D.DR_DEA_NUMB,D.DR_USERNAME,D.DR_ID, D.DG_ID, DG.DC_ID, DG.DG_NAME ,
	  D.DR_ADDRESS1, D.DR_ADDRESS2, D.DR_CITY,
		D.DR_STATE, D.DR_ZIP, D.DR_PHONE,D.DR_EMAIL, D.RIGHTS, D.DR_FAX, 
		PRESCRIBING_AUTHORITY FROM DOCTORS D INNER JOIN DOC_GROUPS DG ON D.DG_ID = DG.DG_ID 
		WHERE DG.DC_ID = @DoctorCompanyId  AND  PRESCRIBING_AUTHORITY>2
		AND D.DR_ENABLED = 1 and loginlock = 0 and lowusage_lock = 0 
		AND (D.billing_enabled=0 or (D.billing_enabled=1 and D.billingDate > getdate()))
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
