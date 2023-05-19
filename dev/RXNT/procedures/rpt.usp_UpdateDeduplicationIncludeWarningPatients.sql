SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to update Deduplication Warning Patient
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_UpdateDeduplicationIncludeWarningPatients]
(
	@CompanyId							BIGINT,
	@DoctorCompanyDeduplicateRequestId	BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;	
	DECLARE @CreatedDate AS DATETIME
	DECLARE @CreatedBy AS BIGINT
	
	SET @CreatedDate = GETDATE()

	SET @CreatedBy = 1
		
	Update	rpt.DeduplicationPatients 
	Set		IncludeWarningPatient = 1
	WHERE	DeduplicationPatientId in 
	(Select  DSP.DeduplicationPatientId
	From	rpt.DeduplicationPatients DSP WITH (NOLOCK)
			INNER JOIN dbo.patients pat WITH (NOLOCK) on pat.pa_id = DSP.PatientId 
			INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id and dg.dc_id = DSP.CompanyId
			INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) ON DT.DuplicationTypeId = DSP.DuplicationTypeId
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = DSP.ProcessStatusTypeId
																		AND SPS.Code = 'PENDG'
	Where	DT.Code = 'FLGNR' and DT.IsWarning = 1 
			AND DG.dc_id = @CompanyId
			AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
			AND pa_dob IS NULL OR CAST(pa_dob AS DATE) = '1901/01/01' or CAST(pa_dob AS DATE) = '1900/01/01'
	)	

	Update	rpt.DeduplicationPatients 
	Set		IncludeWarningPatient = 1
	WHERE	DeduplicationPatientId in 
	(Select  DSP.DeduplicationPatientId
	From	rpt.DeduplicationPatients DSP WITH (NOLOCK)
			INNER JOIN dbo.patients pat WITH (NOLOCK) on pat.pa_id = DSP.PatientId 
			INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id and dg.dc_id = DSP.CompanyId
			INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) ON DT.DuplicationTypeId = DSP.DuplicationTypeId
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = DSP.ProcessStatusTypeId
																		AND SPS.Code = 'PENDG'
	Where	DT.Code = 'FNLNM' and DT.IsWarning = 1 
			AND DG.dc_id = @CompanyId
			AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
			AND pa_dob IS NULL OR CAST(pa_dob AS DATE) = '1901/01/01' or CAST(pa_dob AS DATE) = '1900/01/01'
	)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
