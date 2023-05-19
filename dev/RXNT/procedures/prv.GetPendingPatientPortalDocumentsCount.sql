SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	13-DEC-2017
Description			:	This procedure is used to get pending Patient portal documents count
Last Modified By	:	Ayja Weems
Last Modifed Date	:	12-Apr-2021
Last Modification	:	Include intake & consent forms count in total documents count
=======================================================================================
*/
CREATE PROCEDURE [prv].[GetPendingPatientPortalDocumentsCount]	
	@DoctorId			BIGINT,
	@DoctorGroupId		BIGINT
	
AS
BEGIN

	Declare @Count as int

	SELECT @Count=COUNT(*)
	FROM
	(
		-- Get all unaccepted PatientPortalDocuments
		SELECT PatientPortalDocumentId,
		DoctorId,
		PatientId
		FROM [phr].[PatientPortalDocuments] WITH(NOLOCK)
		WHERE Active = 1 AND IsAccepted IS NULL
		UNION ALL
		-- select all unreviewed intake & consent forms
		SELECT electronic_form_id AS 'PatientPortalDocumentId',
		src_dr_id AS 'DoctorId',
		pat_id AS 'PatientId'
		FROM [dbo].[patient_electronic_forms] WITH(NOLOCK)
		WHERE is_reviewed_by_prescriber = 0
	) pending_documents
	INNER JOIN DOCTORS B WITH(NOLOCK) ON DoctorId = B.DR_ID
	INNER JOIN PATIENTS PAT WITH(NOLOCK) ON PatientId=PAT.pa_id
	WHERE DoctorId = @DoctorId AND B.DG_ID=@DoctorGroupId
  
	Select @Count as DocumentsCount	
  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
