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
CREATE PROCEDURE [rpt].[usp_GetDeduplicationPatients]
(
	@CompanyId				BIGINT,
	@FirstName				VARCHAR(100) = NULL,
	@LastName				VARCHAR(100) = NULL,
	@DOB					DATETIME2 = NULL,
	@ChartNumber			VARCHAR(100) = NULL,
	@ExtendedChartNumber	VARCHAR(100) = NULL,
	@ZipCode				VARCHAR(20) = NULL,
	@PageSize				INT,
	@CurrentPageIndex		INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @StartRowNumber AS INT
	DECLARE @EndRowNumber AS INT

	SET @StartRowNumber = @CurrentPageIndex
	SET @EndRowNumber = @CurrentPageIndex + @PageSize

	DECLARE @DoctorCompanyRequestId AS BIGINT

	SELECT TOP 1 @DoctorCompanyRequestId = DoctorCompanyDeduplicateRequestId
	FROM	rpt.DoctorCompanyDeduplicateRequests DCDR WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DCDR.ProcessStatusTypeId
																AND PST.Code = 'SUCES'
	WHERE	CompanyId = @CompanyId
	ORDER BY DoctorCompanyDeduplicateRequestId DESC

	DECLARE @TempPatients AS TABLE (DeduplicationPatientGroupId BIGINT)

	INSERT INTO @TempPatients
	SELECT	DPP.DeduplicationPatientGroupId
	FROM	rpt.DeduplicationPatients DPP WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = DPP.ProcessStatusTypeId
																		AND SPS.Code = 'PENDG'
			INNER JOIN dbo.doc_companies CMP WITH (NOLOCK) on CMP.dc_id = DPP.CompanyId
			INNER JOIN dbo.patients pat WITH (NOLOCK) ON pat.pa_id = DPP.PatientId AND pat.dg_id > 0 AND ISNULL(pat.active, 1) = 1
	WHERE	DPP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId AND DPP.Active = 1
			AND (ISNULL(pat.pa_first, '') LIKE @FirstName + '%' OR @FirstName IS NULL)
			AND (ISNULL(pat.pa_last, '') LIKE @LastName + '%' OR @LastName IS NULL)
			AND (ISNULL(pat.pa_ssn, '') LIKE @ChartNumber + '%' OR @ChartNumber IS NULL)
			AND (ISNULL(pat.pa_ext_ssn_no, '') LIKE @ExtendedChartNumber + '%' OR @ExtendedChartNumber IS NULL)
			AND (pat.pa_dob = @DOB OR @DOB IS NULL)
			AND (ISNULL(pat.pa_zip, '') = @ZipCode OR @ZipCode IS NULL)
	group by DPP.DeduplicationPatientGroupId
	having COUNT(*) > 1
	Order by DPP.DeduplicationPatientGroupId
	
	SELECT * INTO #TempDeduplicationPatient 
	FROM
	(
	   SELECT	ROW_NUMBER() OVER(ORDER BY DeduplicationPatientGroupId DESC) NUM, * 
	   FROM		@TempPatients
	) A
	WHERE NUM >= @StartRowNumber AND NUM < @EndRowNumber

	SELECT DISTINCT DSP.PatientId pa_id INTO #dischargeFlags
	FROM #TempDeduplicationPatient tmp
		INNER JOIN rpt.DeduplicationPatientGroups DPG WITH (NOLOCK) on DPG.DeduplicationPatientGroupId = tmp.DeduplicationPatientGroupId
		INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) ON PST.ProcessStatusTypeId = DPG.ProcessStatusTypeId AND PST.Code = 'PENDG'
		INNER JOIN rpt.DeduplicationPatients DSP WITH (NOLOCK) ON DSP.DeduplicationPatientGroupId = DPG.DeduplicationPatientGroupId
		INNER JOIN [RxNT].[dbo].[patient_flag_details] PFD WITH (NOLOCK) ON PFD.pa_id = DSP.PatientId 
		INNER JOIN [RxNT].[dbo].[patient_flags] PF WITH (NOLOCK) ON PF.flag_id = PFD.flag_id
	WHERE PF.[flag_title] LIKE '%DISCHARGE%'
	
	SELECT	DPG.DeduplicationPatientGroupId, 
			DPG.DoctorCompanyDeduplicateRequestId,
			DPG.CompanyId,
			DPG.IncludeForMerge,
			DPG.GroupName
	FROM	#TempDeduplicationPatient tmp 
			INNER JOIN rpt.DeduplicationPatientGroups DPG WITH (NOLOCK) on DPG.DeduplicationPatientGroupId = tmp.DeduplicationPatientGroupId
			INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) ON PST.ProcessStatusTypeId = DPG.ProcessStatusTypeId
																		AND PST.Code = 'PENDG'
	WHERE	DPG.DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId AND DPG.Active = 1
	Order by DPG.DeduplicationPatientGroupId DESC

	SELECT	DSP.DeduplicationPatientId, DSP.DeduplicationPatientGroupId, DSP.DoctorCompanyDeduplicateRequestId,
			DSP.DuplicationText, DSP.CompanyId, DSP.PatientId, DT.Name As DuplicationName, DT.Description As DuplicationDescription,
			CMP.dc_Name As CompanyName, pat.pa_first, pat.pa_last, pat.pa_middle, pat.pa_ssn, pat.pa_dob, pat.pa_address1, pat.pa_address2,
			pat.pa_city, pat.pa_state, pat.pa_zip, pat.pa_phone, pat.dr_id, pat.pa_suffix, pat.pa_prefix, pat.pa_email, pat.pa_sex, pat.pa_ext_ssn_no ,
			DT.IsWarning, 
			DSP.IsIndirectMapping,
			DSP.IndirectMappingComments,
			DSP.IncludeWarningPatient,
			DSP.IncludePatientForMerge,
			DSP.Level,
			DPG.IncludeForMerge,
			DPG.GroupName,
			CAST (ISNULL(DF.pa_id, 0) AS bit) as IsDischarged
	FROM	#TempDeduplicationPatient tmp 
			INNER JOIN rpt.DeduplicationPatientGroups DPG WITH (NOLOCK) on DPG.DeduplicationPatientGroupId = tmp.DeduplicationPatientGroupId
			INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) ON PST.ProcessStatusTypeId = DPG.ProcessStatusTypeId
																		AND PST.Code = 'PENDG'
			INNER JOIN rpt.DeduplicationPatients DSP WITH (NOLOCK) ON DSP.DeduplicationPatientGroupId = DPG.DeduplicationPatientGroupId
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = DSP.ProcessStatusTypeId
																		AND SPS.Code = 'PENDG'
			INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) ON DT.DuplicationTypeId = DSP.DuplicationTypeId
			INNER JOIN dbo.doc_companies CMP WITH (NOLOCK) on CMP.dc_id = DSP.CompanyId
			INNER JOIN dbo.patients pat WITH (NOLOCK) ON pat.pa_id = DSP.PatientId 
			INNER JOIN dbo.doc_groups DG WITH (NOLOCK) ON DG.dg_id = pat.dg_id AND DG.dc_id = @CompanyId 
			LEFT OUTER JOIN #dischargeFlags DF ON DSP.PatientId = DF.pa_id
	WHERE	DSP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId AND DSP.Active = 1
	Order by DSP.DeduplicationPatientGroupId DESC, DSP.DeduplicationPatientId --DSP.Level,

	SELECT	Count(*) As TotalNoOfRecords
	FROM	@TempPatients	

	DROP TABLE IF EXISTS  #dischargeFlags
	DROP TABLE IF EXISTS  #TempDeduplicationPatient
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
