SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to search patients
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_SearchPatientsForMerge]
(
	@CompanyId	BIGINT,
	@FirstName	VARCHAR(100) = NULL,
	@LastName	VARCHAR(100) = NULL,
	@DOB		DATETIME2 = NULL,
	@ChartNumber	VARCHAR(100) = NULL,
	@ExtendedChartNumber VARCHAR(100) = NULL,
	@ZipCode VARCHAR(20) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;	
	SELECT DISTINCT TOP 100 P.PA_ID, P.DR_ID, P.PA_PREFIX, P.PA_SUFFIX, P.PA_LAST, P.PA_FIRST,P.PA_FLAG, 
			P.PA_MIDDLE, P.PA_SSN, P.PA_ZIP, P.PA_DOB, P.PA_ADDRESS1, P.PA_EMAIL, P.PA_ADDRESS2, P.PA_CITY, 
			P.PA_SEX, P.PA_STATE, P.PA_PHONE,pa_ext_ssn_no,pa_ins_type,pa_race_type,pa_ethn_type,pref_lang,PE.CELL_PHONE,
			CASE WHEN MRQ.pa_merge_batchid IS NULL THEN 0 ELSE 1 END AS 'ISQUEUE'
    FROM	dbo.PATIENTS P WITH(NOLOCK) 
			LEFT OUTER JOIN dbo.PATIENT_EXTENDED_DETAILS PE WITH(NOLOCK) ON P.PA_ID = PE.PA_ID 
			LEFT OUTER JOIN (Select MAX(MRQ.pa_merge_batchid) As pa_merge_batchid, MRQ.secondary_pa_id
			FROM dbo.PATIENT_MERGE_REQUEST_QUEUE MRQ WITH(NOLOCK)  
			INNER JOIN dbo.PATIENT_MERGE_REQUEST_BATCH MRB WITH(NOLOCK) ON MRB.pa_merge_batchid= MRQ.pa_merge_batchid
			WHERE MRQ.status = 1 AND MRB.status= 1
			group by MRQ.secondary_pa_id ) MRQ ON MRQ.SECONDARY_PA_ID = P.PA_ID
    WHERE	MRQ.pa_merge_batchid IS NULL 
			AND (ISNULL(P.pa_first, '') LIKE @FirstName + '%' OR @FirstName IS NULL)
			AND (ISNULL(P.pa_last, '') LIKE @LastName + '%' OR @LastName IS NULL)
			AND (ISNULL(P.pa_ssn, '') LIKE @ChartNumber + '%' OR @ChartNumber IS NULL)
			AND (ISNULL(P.pa_ext_ssn_no, '') LIKE @ExtendedChartNumber + '%' OR @ExtendedChartNumber IS NULL)
			AND (P.pa_dob = @DOB OR @DOB IS NULL)
			AND (ISNULL(P.pa_zip, '') = @ZipCode OR @ZipCode IS NULL)
			AND P.DG_ID  IN (SELECT DG_ID FROM dbo.DOC_GROUPS WHERE DC_ID = @CompanyId)
	order by p.pa_last, p.pa_first

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
