SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =======================================================================
-- Author:		      ?
-- Create date:       ?
-- Description:	      Search Prescribing Doctors
-- Modified By:       Ayja Weems
-- Modified Date:     28-Apr-2021
-- Last Modification: Include professional_designation & conditional
--					  dr_last_auth_dr_id in select
-- ======================================================================
CREATE PROCEDURE [prv].[usp_SearchPrescribingDoctors]
  @DoctorGroupId INT
AS
BEGIN
  SET NOCOUNT ON;
  SELECT d.dr_first_name,
    d.epcs_enabled,
    d.dr_prefix,
    d.dr_enabled, 
    d.loginlock, 
    d.dr_suffix, 
    d.hipaa_agreement_acptd, 
    d.dr_agreement_acptd, 
    d.dr_def_rxcard_history_back_to, 
    d.dr_rxcard_search_consent_type, 
    d.dr_def_pat_history_back_to, 
    d.npi, 
    d.time_difference, 
    d.dr_middle_initial, 
    d.dr_last_name, 
    d.dr_dea_numb, 
    d.dr_id, 
    d.dg_id, 
    dg.dc_id, 
    d.dr_address1, 
    d.dr_address2, 
    d.dr_city,
    d.dr_state, 
    d.dr_zip, 
    d.dr_phone, 
    d.rights, 
    d.dr_email, 
    d.dr_fax, 
    prescribing_authority, 
    df.appointment_duration,
    d.professional_designation,
	CASE 
		WHEN prescribing_authority = 3
		THEN d.dr_last_auth_dr_id
		ELSE null
	END AS dr_last_auth_dr_id
  FROM doctors d INNER JOIN doc_groups dg ON d.dg_id = dg.dg_id
    LEFT OUTER JOIN doc_fav_info df ON d.dr_id = df.dr_id
  WHERE d.dg_id = @DoctorGroupId
    AND d.dr_enabled = 1 AND loginlock = 0 
    AND lowusage_lock = 0 
    AND (d.billing_enabled = 0 OR (d.billing_enabled = 1 and d.billingDate > getdate())) 
    AND d.PRESCRIBING_AUTHORITY >= 3
  ORDER BY dr_last_name, dr_first_name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
