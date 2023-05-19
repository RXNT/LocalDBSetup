SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Balaji
-- Create date: 01-Sept-2016
-- Description:	Get Doctor Details
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [prv].[usp_GetDoctor]
	@DoctorCompanyId BIGINT,
	@DoctorId BIGINT
AS
BEGIN
	 SELECT D.DR_FIRST_NAME,D.epcs_enabled,D.dr_enabled,loginlock, D.DR_PREFIX, D.DR_SUFFIX, d.hipaa_agreement_acptd,
	  D.dr_agreement_acptd, d.dr_def_rxcard_history_back_to, d.dr_rxcard_search_consent_type, 
	  D.dr_def_pat_history_back_to, D.NPI, D.TIME_DIFFERENCE, D.DR_MIDDLE_INITIAL, D.DR_LAST_NAME, D.DR_DEA_NUMB,
	  D.DR_USERNAME,D.DR_ID, D.DG_ID, DG.DC_ID, DG.DG_NAME , D.DR_ADDRESS1, D.DR_ADDRESS2, D.DR_CITY,
      D.DR_STATE, D.DR_ZIP, D.DR_PHONE,D.DR_EMAIL, D.RIGHTS, D.DR_FAX, PRESCRIBING_AUTHORITY , dg.emr_modules dg_modules,
	  DI.EnableRulesEngine, DC.EnableRulesEngine As CompanyEnableRulesEngine
      FROM DOCTORS D 
      INNER JOIN DOC_GROUPS DG ON D.DG_ID = DG.DG_ID 
      INNER JOIN DOC_COMPANIES DC WITH(NOLOCK) ON DC.DC_ID = DG.DC_ID 
	  LEFT JOIN doctor_info DI ON DI.dr_id=D.dr_id
      WHERE D.dr_id=@DoctorId AND DG.DC_ID = @DoctorCompanyId  AND D.DR_ENABLED = 1 and loginlock = 0 
      and lowusage_lock = 0 AND (D.billing_enabled=0 or (D.billing_enabled=1 and D.billingDate > getdate()))
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
