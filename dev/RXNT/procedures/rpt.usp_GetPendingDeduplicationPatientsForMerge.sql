SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to get deduplication patients
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_GetPendingDeduplicationPatientsForMerge]
(
	@CompanyId				BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @DoctorCompanyRequestId AS BIGINT

	SELECT TOP 1 @DoctorCompanyRequestId = DoctorCompanyDeduplicateRequestId
	FROM	rpt.DoctorCompanyDeduplicateRequests DCDR WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DCDR.ProcessStatusTypeId
																AND PST.Code = 'SUCES'
	WHERE	CompanyId = @CompanyId
	ORDER BY DoctorCompanyDeduplicateRequestId DESC

	DECLARE @TempPatients AS TABLE (DeduplicationPatientGroupId BIGINT)

	INSERT INTO @TempPatients
	SELECT	Distinct DPP.DeduplicationPatientGroupId
	FROM	rpt.DeduplicationPatientGroups DPP WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = DPP.ProcessStatusTypeId
																		AND SPS.Code = 'PENDG'
	WHERE	DPP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId AND DPP.Active = 1
			AND DPP.IncludeForMerge = 1
	Order by DPP.DeduplicationPatientGroupId
	
	SELECT	DPG.DeduplicationPatientGroupId, 
			DPG.DoctorCompanyDeduplicateRequestId,
			DPG.CompanyId,
			DPG.IncludeForMerge,
			DPG.GroupName
	FROM	@TempPatients tmp 
			INNER JOIN rpt.DeduplicationPatientGroups DPG WITH (NOLOCK) on DPG.DeduplicationPatientGroupId = tmp.DeduplicationPatientGroupId
			INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) ON PST.ProcessStatusTypeId = DPG.ProcessStatusTypeId
																		AND PST.Code = 'PENDG'
	WHERE	DPG.DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId AND DPG.Active = 1
	Order by DPG.DeduplicationPatientGroupId

	SELECT	DSP.DeduplicationPatientId, DSP.DeduplicationPatientGroupId, DSP.DoctorCompanyDeduplicateRequestId,
			DSP.DuplicationText, DSP.CompanyId, DSP.PatientId, DT.Name As DuplicationName, DT.Description As DuplicationDescription,
			CMP.dc_Name As CompanyName, pat.pa_first, pat.pa_last, pat.pa_middle, pat.pa_ssn, pat.pa_dob, pat.pa_address1, pat.pa_address2,
			pat.pa_city, pat.pa_state, pat.pa_zip, pat.pa_phone, pat.dr_id, pat.pa_suffix, pat.pa_prefix, pat.pa_email, pat.pa_sex, pat.pa_ext_ssn_no ,
			DT.IsWarning, 
			DSP.IsIndirectMapping,
			DSP.IndirectMappingComments,
			DSP.IncludeWarningPatient,
			DSP.IncludePatientForMerge,
			DSP.Level
	FROM	@TempPatients tmp 
			INNER JOIN rpt.DeduplicationPatients DSP WITH (NOLOCK) ON DSP.DeduplicationPatientGroupId = tmp.DeduplicationPatientGroupId
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = DSP.ProcessStatusTypeId
																		AND SPS.Code = 'PENDG'
			INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) ON DT.DuplicationTypeId = DSP.DuplicationTypeId
			INNER JOIN dbo.doc_companies CMP WITH (NOLOCK) on CMP.dc_id = DSP.CompanyId
			INNER JOIN dbo.patients pat WITH (NOLOCK) ON pat.pa_id = DSP.PatientId 
			INNER JOIN dbo.doc_groups DG WITH (NOLOCK) ON DG.dg_id = pat.dg_id 
														AND DG.dc_id = @CompanyId 
	WHERE	DSP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId AND DSP.Active = 1
			AND DSP.IncludePatientForMerge = 1
	Order by DSP.DeduplicationPatientGroupId, DSP.DeduplicationPatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
