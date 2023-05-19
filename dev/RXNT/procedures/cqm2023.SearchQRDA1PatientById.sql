SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	24-NOV-2022
-- Description:		Search QRDA Patient By PatientId
-- =============================================
CREATE    PROCEDURE [cqm2023].[SearchQRDA1PatientById]
  @PatientId			BIGINT
AS
BEGIN
 
	
	DECLARE @MaritalStatus AS VARCHAR(30)
	DECLARE @RaceId AS VARCHAR(30)
	DECLARE @EthnicityId AS VARCHAR(30)
	DECLARE @LanguageId AS VARCHAR(30)
	
	SELECT @RaceId = slc.Code FROM ehr.SysLookupCodes slc WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON slc.ApplicationTableConstantCode=CONVERT(varchar(30), pat.pa_race_type)
	INNER JOIN ehr.SysLookupCodeSystem slcs WITH(NOLOCK) ON slc.CodeSystemId=slcs.CodeSystemId
	WHERE pat.pa_id=@PatientId AND slcs.ApplicationTableCode='PARCA'
	
	SELECT @EthnicityId = slc.Code FROM ehr.SysLookupCodes slc WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON slc.ApplicationTableConstantCode=CONVERT(varchar(30), pat.pa_ethn_type)
	INNER JOIN ehr.SysLookupCodeSystem slcs WITH(NOLOCK) ON slc.CodeSystemId=slcs.CodeSystemId
	WHERE pat.pa_id=@PatientId AND slcs.ApplicationTableCode='PAETN'
	
	--SELECT @EthnicityId = ATC.Code FROM ehr.ApplicationTableConstants ATC WITH(NOLOCK)
	--INNER JOIN dbo.patient_ethnicity_details paethn WITH(NOLOCK) ON ATC.ApplicationTableConstantId=paethn.ethnicity_id
	--WHERE paethn.pa_id=@PatientId
	
	SELECT @LanguageId = slc.Code FROM ehr.SysLookupCodes slc WITH(NOLOCK)
	INNER JOIN [dbo].[PreferredLanguages] PL WITH(NOLOCK) ON slc.ApplicationTableConstantCode = PL.Code
	INNER JOIN patients pat WITH(NOLOCK) ON PL.PreferredLanguageId=CONVERT(varchar(30), pat.pref_lang)
	INNER JOIN ehr.SysLookupCodeSystem slcs WITH(NOLOCK) ON slc.CodeSystemId=slcs.CodeSystemId
	WHERE pat.pa_id=@PatientId AND slcs.ApplicationTableCode='LANGU'
	
	SELECT pat.pa_id,dg_id, pat.dr_id, pa_prefix, pa_suffix, pa_first, pa_middle, pa_last, pa_ssn, pa_dob, pa_address1, pa_address2, pa_city, pa_state, 
	pa_zip, pa_phone, pa_sex, pa_flag, pa_ext_ssn_no, pa_ins_type, @RaceId as PatientRace, @EthnicityId as PatientEthinicity, @LanguageId as PatientLanguage, pa_email,add_by_user, OwnerType,
	patext.cell_phone,patext.work_phone, patext.other_phone, patext.pref_phone, patext.marital_status
	FROM patients pat WITH(NOLOCK)
	LEFT OUTER JOIN patient_extended_details patext WITH(NOLOCK) ON pat.pa_id=patext.pa_id
	WHERE pat.pa_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
