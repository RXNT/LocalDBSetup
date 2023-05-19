SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinoth
Create date			:	07-December-2017
Description			:	Get All Patient Portal Documents
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_GetAllPatientPortalDocuments]
(	
	@PatientId          BIGINT,
    @IncludeDeleted     BIT,
    @StartDate          DATETIME        = NULL,
    @EndDate            DATETIME        = NULl
)
AS
BEGIN
	SELECT	PPD.PatientPortalDocumentId,PPD.PatientId,PPD.DoctorCompanyId,PPD.DoctorId,
	D.dr_last_name + '' + D.dr_first_name as DoctorName,
	IsAccepted,PPD.Title,PPD.Description,
	PPD.FilePath,PPD.FileName,PPD.CreatedDate,PPD.Active,PPD.ActionDate,PPD.Comments,
	PPD.PatientRepresentativeId,
	PR.FirstName,
	PR.LastName,
	PR.MiddleInitial
	FROM	phr.PatientPortalDocuments PPD WITH (NOLOCK)
			INNER JOIN dbo.doctors D WITH(NOLOCK) ON PPD.DoctorId = D.dr_id
			LEFT JOIN phr.PatientRepresentatives PR WITH(NOLOCK) ON PPD.PatientRepresentativeId = PR.PatientRepresentativeId
    WHERE (@IncludeDeleted = 1 OR (ISNULL(@IncludeDeleted, 0) = 0 AND PPD.active=1)) AND
		  (PPD.PatientId = @PatientId OR ISNULL(@PatientId, 0) = 0) AND
		  ((@StartDate IS NULL AND @EndDate IS NULL) OR 
		  (DATEADD(D, 0, DATEDIFF(D, 0, PPD.CreatedDate)) 
		  BETWEEN DATEADD(D, 0, DATEDIFF(D, 0, @StartDate)) AND DATEADD(D, 0, DATEDIFF(D, 0, @EndDate))))
	ORDER BY PPD.CreatedDate DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
