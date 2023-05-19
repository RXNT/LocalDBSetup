SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to search deduplication dc request
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_GetPatientsDeduplicateRecords]
(
	@DoctorCompanyDeduplicateRequestId	BIGINT,
	@CompanyId							BIGINT,
	@ProcessStatusTypeId				BIGINT,
	@DuplicationTypeId					BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT	SMDR.*, SPS.Code As ProcessTypeCode, SPS.Name As ProcessTypeName, 
			DT.Code As DuplicationTypeCode, DT.Name As DuplicationTypeName, DT.Weightage,
			CMP.dc_Name As CompanyName
	FROM	rpt.DoctorCompanyDeduplicationTransition SMDR WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = SMDR.ProcessStatusTypeId
			INNER JOIN dbo.doc_companies CMP WITH (NOLOCK) on CMP.dc_id = SMDR.CompanyId
			INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) on DT.DuplicationTypeId = SMDR.DuplicationTypeId
	WHERE	SMDR.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
			AND (SMDR.ProcessStatusTypeId = @ProcessStatusTypeId OR @ProcessStatusTypeId IS NULL)
			AND (SMDR.DuplicationTypeId = @DuplicationTypeId OR @DuplicationTypeId IS NULL)
			AND SMDR.CompanyId = @CompanyId
			AND SMDR.Active = 1

	SELECT	DCDPT.*, SPS.Code As ProcessTypeCode, SPS.Name As ProcessTypeName, 
			DT.Code As DuplicationTypeCode, DT.Name As DuplicationTypeName, 
			CMP.dc_Name As CompanyName, pat.pa_first, pat.pa_last, pat.pa_middle, pat.pa_last, pat.pa_ssn, pat.pa_dob, pat.pa_address1, pat.pa_address2,
			pat.pa_city, pat.pa_state, pat.pa_zip, pat.pa_phone, pat.dr_id, pat.pa_suffix, pat.pa_prefix, pat.pa_email, pat.pa_sex 
	FROM	rpt.DoctorCompanyDeduplicationPatientTransition DCDPT WITH (NOLOCK)
			INNER JOIN rpt.DoctorCompanyDeduplicationTransition SMDR WITH (NOLOCK) ON SMDR.DoctorCompanyDeduplicationTransitionId = DCDPT.DoctorCompanyDeduplicationTransitionId
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = DCDPT.ProcessStatusTypeId
			INNER JOIN dbo.doc_companies CMP WITH (NOLOCK) on CMP.dc_id = SMDR.CompanyId
			INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) on DT.DuplicationTypeId = SMDR.DuplicationTypeId
			INNER JOIN dbo.patients pat WITH (NOLOCK) ON pat.pa_id = DCDPT.PatientId
	WHERE	SMDR.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
			AND (DCDPT.ProcessStatusTypeId = @ProcessStatusTypeId OR @ProcessStatusTypeId IS NULL)
			AND (SMDR.DuplicationTypeId = @DuplicationTypeId OR @DuplicationTypeId IS NULL)
			AND SMDR.CompanyId = @CompanyId
			AND DCDPT.Active = 1
			AND SMDR.Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
