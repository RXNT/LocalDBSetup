SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[usp_SearchAuthorizedDoctors]
	 @DoctorGroupId INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT d.dr_first_name,d.epcs_enabled, d.dr_prefix,d.dr_enabled,d.loginlock, d.dr_suffix, d.hipaa_agreement_acptd, d.dr_agreement_acptd, d.dr_def_rxcard_history_back_to, d.dr_rxcard_search_consent_type, d.dr_def_pat_history_back_to, d.npi, d.time_difference, d.dr_middle_initial, d.dr_last_name, d.dr_dea_numb, d.dr_id, d.dg_id,dg.dc_id, d.dr_address1, d.dr_address2, d.dr_city,
	D.DR_STATE, D.DR_ZIP, D.DR_PHONE, D.RIGHTS,D.DR_EMAIL, D.DR_FAX, PRESCRIBING_AUTHORITY, DF.APPOINTMENT_DURATION FROM DOCTORS D INNER JOIN DOC_GROUPS DG ON D.DG_ID = DG.DG_ID
	LEFT OUTER JOIN DOC_FAV_INFO DF ON D.DR_ID = DF.DR_ID 
	WHERE D.DG_ID = @DoctorGroupId
	AND D.DR_ENABLED = 1  and loginlock = 0 and lowusage_lock = 0 AND prescribing_authority=4 AND (D.billing_enabled=0 or (D.billing_enabled=1 and D.billingDate > getdate()))  AND D.PRESCRIBING_AUTHORITY >= 3 order by dr_first_name,DR_LAST_NAME
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
