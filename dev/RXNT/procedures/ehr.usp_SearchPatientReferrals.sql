SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 6-Oct-2016
-- Description:	To Search Patient Referrals
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_SearchPatientReferrals]
  @PatientId INT,
  @DoctorGroupId INT
AS
BEGIN
	SELECT R.REF_ID,R.REF_START_DATE, R.REFERRAL_VERSION,
	T.FIRST_NAME, T.LAST_NAME, T.GROUPNAME, T.address1,T.phone,T.fax,T.city,T.state,T.zip, T.PHONE,T.FAX,
    RS.INST_NAME, 
    S.RESPONSE_DATE, S.RESPONSE_TYPE, S.RESPONSE_TEXT, S.DELIVERY_METHOD
    FROM REFERRAL_MAIN R 
    LEFT OUTER JOIN REFERRAL_TARGET_DOCS T ON R.TARGET_DR_ID = T.TARGET_DR_ID
    LEFT OUTER JOIN referral_institutions RS ON R.INST_ID = RS.INST_ID
    LEFT OUTER JOIN REFERRAL_STATUS S ON R.REF_ID = S.REFERRAL_ID
    INNER JOIN doctors D ON R.main_dr_id=D.dr_id
    WHERE R.PA_ID = @PatientId  AND D.dg_id = @DoctorGroupId 
    ORDER BY R.REF_ID DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
