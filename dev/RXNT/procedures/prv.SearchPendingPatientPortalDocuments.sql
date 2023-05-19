SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:				Nambi
-- Created Date: 		13-DEC-2017
-- Description:			Search Pending Patient Portal Documents including intake and consent forms
-- Modified By:			Ayja Weems
-- Modified Date:		10-FEB-2021
-- Last Modification:	Include intake & consent forms that have not been reviewed
-- =============================================
CREATE PROCEDURE [prv].[SearchPendingPatientPortalDocuments]
	@DoctorId			BIGINT,
	@DoctorGroupId		BIGINT,
	@PatientFirstName	VARCHAR(50) = NULL,
	@PatientLastName	VARCHAR(50) = NULL
AS
BEGIN

SELECT pending_documents.*, 
	PAT.pa_last,
	PAT.pa_first,
	PE.pa_nick_name,
	(SELECT COUNT (1) FROM dbo.patients WITH (NOLOCK)
		WHERE pa_id = PatientId AND ( 
		pa_first IS NULL OR pa_first = '' OR
		pa_last IS NULL OR pa_last = '' OR
		pa_dob IS NULL OR pa_dob = '' OR
		pa_sex IS NULL OR pa_sex = '' OR
		pa_address1 IS NULL OR pa_address1 = '' OR
		pa_zip IS NULL OR pa_zip = '' OR
		pa_state IS NULL OR pa_state = '' )
	) AS patient_details_missing
FROM (
	SELECT A.PatientPortalDocumentId, 
		A.PatientId, 
		A.DoctorId, 
		A.CreatedDate, 
		A.Title, 
		A.Description, 
		A.FileName, 
		A.FilePath
	FROM [phr].[PatientPortalDocuments] A WITH(NOLOCK)
	WHERE 
		A.Active = 1 
		AND A.IsAccepted IS NULL
		AND DoctorId = @DoctorId 
	UNION ALL
	-- select all unreviewed intake & consent forms and format them to match the PatientPortalDocuments
	SELECT electronic_form_id AS 'PatientPortalDocumentId',
		pat_id AS 'PatientId',
		src_dr_id AS 'DoctorId',
		upload_date AS 'CreatedDate',
		CASE WHEN type = 1
			THEN 'Consent Form'
			ELSE 'Intake Form'
		END AS Title,
		title AS 'Description',
		title AS 'FileName',
		filename AS 'FilePath'
	FROM patient_electronic_forms WITH(NOLOCK)
	WHERE is_reviewed_by_prescriber = 0
) pending_documents
INNER JOIN DOCTORS B WITH(NOLOCK) ON DoctorId = B.DR_ID
INNER JOIN PATIENTS PAT WITH(NOLOCK) ON PatientId=PAT.pa_id
LEFT OUTER JOIN [patient_extended_details] PE WITH(NOLOCK) ON PE.pa_id = PAT.pa_id 
WHERE 
	B.DG_ID=@DoctorGroupId
	AND (@PatientFirstName IS NULL OR PAT.pa_first LIKE '%'+@PatientFirstName+'%')
	AND (@PatientLastName IS NULL OR PAT.pa_last LIKE '%'+@PatientLastName+'%')
ORDER BY CreatedDate DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
