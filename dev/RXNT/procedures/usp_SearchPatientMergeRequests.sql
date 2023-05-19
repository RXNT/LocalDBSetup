SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_SearchPatientMergeRequests]
(
	@CompanyId				BIGINT,
	@FirstName				VARCHAR(100) = NULL,
	@LastName				VARCHAR(100) = NULL,
	@DOB					DATETIME2 = NULL,
	@ChartNumber			VARCHAR(100) = NULL,
	@ExtendedChartNumber	VARCHAR(100) = NULL,
	@ZipCode				VARCHAR(20) = NULL,
	@BatchName				VARCHAR(100),
	@RequestFromDate		DATETIME2,
	@RequestToDate			DATETIME2,
	@Status					VARCHAR(50)
) WITH RECOMPILE
AS
BEGIN
	
	SET NOCOUNT ON;	

	DECLARE @TempMergeRequests TABLE (
		pa_merge_batchid BIGINT NOT NULL,
		pa_merge_reqid BIGINT NOT NULL	
	)

	INSERT INTO @TempMergeRequests

	SELECT DISTINCT mrb.pa_merge_batchid, mrq.pa_merge_reqid
	from	dbo.Patient_merge_request_batch mrb WITH (NOLOCK)
			INNER JOIN dbo.Patient_merge_request_queue mrq WITH (NOLOCK) on mrb.pa_merge_batchid = mrq.pa_merge_batchid
			inner join  dbo.patient_merge_status ms WITH (NOLOCK) on mrb.status = ms.statusid 
			left join	dbo.patients prmpa WITH (NOLOCK) on mrq.primary_pa_id = prmpa.pa_id
			left join	dbo.patients secpa WITH (NOLOCK) on mrq.secondary_pa_id = secpa.pa_id 
	where	1 = 1
			AND mrb.dc_id = @CompanyId
			AND mrb.active = 1
			AND mrq.active = 1
			AND (DATEADD(D, 0, DATEDIFF(D, 0, mrb.Created_Date)) between @RequestFromDate AND @RequestToDate
					OR (@RequestFromDate IS NULL AND @RequestToDate IS NULL))
			AND (@Status IS NULL OR LOWER(ms.Status) = LOWER(@Status))
			AND (mrb.batch_name LIKE @BatchName + '%' OR @BatchName IS NULL)
			AND (@FirstName IS NULL OR ISNULL(prmpa.pa_first, '') LIKE @FirstName + '%' OR ISNULL(secpa.pa_first, '') LIKE @FirstName + '%')
			AND (@LastName IS NULL OR ISNULL(prmpa.pa_last, '') LIKE @LastName + '%' OR ISNULL(secpa.pa_last, '') LIKE @LastName + '%')
			AND (@ChartNumber IS NULL OR ISNULL(prmpa.pa_ssn, '') LIKE @ChartNumber + '%' OR ISNULL(secpa.pa_ssn, '') LIKE @ChartNumber + '%')
			AND (@ExtendedChartNumber IS NULL OR ISNULL(prmpa.pa_ext_ssn_no, '') LIKE @ExtendedChartNumber + '%' OR ISNULL(secpa.pa_ext_ssn_no, '') LIKE @ExtendedChartNumber + '%')
			AND (@DOB IS NULL OR prmpa.pa_dob = @DOB OR secpa.pa_dob = @DOB)
			AND (@ZipCode IS NULL OR ISNULL(prmpa.pa_zip, '') = @ZipCode OR ISNULL(secpa.pa_zip, '') = @ZipCode)
			
	SELECT  distinct mrb.pa_merge_batchid, batch_name, mrb.created_date, ms.status, d.dr_last_name, d.dr_first_name,
			UNM.PatientUnmergeRequestId, CASE WHEN ISNULL(bkpat.pa_merge_reqid,0)=0 THEN 0 ELSE 1 END AS isEligibleForUnmerge
	FROM	@TempMergeRequests REQ
			INNER JOIN dbo.Patient_merge_request_batch mrb WITH (NOLOCK) on mrb.pa_merge_batchid = REQ.pa_merge_batchid
			inner join dbo.patient_merge_status ms WITH (NOLOCK) on mrb.status = ms.statusid 
			inner join dbo.doctors d WITH (NOLOCK) on d.dr_id = mrb.created_by
			left join bk.patients bkpat WITH(NOLOCK) on REQ.pa_merge_reqid=bkpat.pa_merge_reqid
			left join (
			Select	Max(PatientUnmergeRequestId) As PatientUnmergeRequestId, pa_merge_batchid
			FROM	dbo.PatientUnmergeRequests UNM WITH (NOLOCK) 
					INNER JOIN dbo.Patient_merge_status STS WITH (NOLOCK) ON STS.StatusId = UNM.StatusId AND STS.Status = 'Pending'
			WHERE	UNM.Active = 1 AND UNM.CompanyId = @CompanyId
			group by pa_merge_batchid) UNM ON UNM.pa_merge_batchid = mrb.pa_merge_batchid 
	order by mrb.created_date DESC
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
