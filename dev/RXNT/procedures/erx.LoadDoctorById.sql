SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To get the doctor information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadDoctorById]
	@DoctorId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT D.DR_FIRST_NAME, D.DR_PREFIX,loginlock,dr_enabled, D.DR_SUFFIX, D.epcs_enabled, D.hipaa_agreement_acptd, D.dr_agreement_acptd,
	D.dr_def_rxcard_history_back_to, D.dr_rxcard_search_consent_type, D.dr_def_pat_history_back_to, D.NPI, D.TIME_DIFFERENCE, D.DR_MIDDLE_INITIAL, 
	D.DR_LAST_NAME,D.DR_USERNAME, D.DR_ID, DG.DG_NAME, D.DG_ID, DG.DC_ID, D.DR_ADDRESS1, D.DR_ADDRESS2, D.DR_CITY,
    D.DR_STATE, D.DR_DEA_NUMB, D.DR_ZIP, D.DR_PHONE,D.DR_EMAIL, D.RIGHTS, D.DR_FAX, PRESCRIBING_AUTHORITY 
    FROM DOCTORS D 
    INNER JOIN DOC_GROUPS DG ON D.DG_ID = DG.DG_ID 
    WHERE D.DR_ID = @DoctorId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
