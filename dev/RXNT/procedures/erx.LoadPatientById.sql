SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To get the patient information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadPatientById]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT P.PA_ID, P.DR_ID, P.PA_PREFIX, P.PA_SUFFIX, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, P.PA_FLAG, P.PA_SSN, P.PA_ZIP, P.PA_DOB,P.PA_EMAIL,
	P.PA_ADDRESS1, P.PA_ADDRESS2, P.PA_CITY, P.PA_SEX, P.PA_STATE, P.PA_PHONE,pa_ext_ssn_no,pa_ins_type,pa_race_type,pa_ethn_type,pref_lang,'' CELL_PHONE,
	'' pa_merge_batchid, '' primary_pa_id  FROM PATIENTS P
    WHERE p.pa_id = @PatientId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
