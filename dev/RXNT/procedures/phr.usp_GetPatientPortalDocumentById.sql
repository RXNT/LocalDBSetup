SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
/*   
=======================================================================================  
Author    : Vinoth  
Create date   : 07-December-2017  
Description   : Get All Patient Portal Documents  
Last Modified By :  
Last Modifed Date :  
=======================================================================================  
*/  
CREATE PROCEDURE [phr].[usp_GetPatientPortalDocumentById]  
(   
 @PatientId          BIGINT,  
 @PatientPortalDocumentId     BIGINT
)  
AS  
BEGIN  
 SELECT PPD.PatientPortalDocumentId,PPD.PatientId,PPD.DoctorCompanyId,PPD.DoctorId,  
 D.dr_last_name + '' + D.dr_first_name as DoctorName,  
 IsAccepted,PPD.Title,PPD.Description,  
 PPD.FilePath,PPD.FileName,PPD.CreatedDate,PPD.Active,PPD.ActionDate,PPD.Comments,  
 PPD.PatientRepresentativeId,  
 PR.FirstName,  
 PR.LastName,  
 PR.MiddleInitial  
 FROM phr.PatientPortalDocuments PPD WITH (NOLOCK)  
   INNER JOIN dbo.doctors D WITH(NOLOCK) ON PPD.DoctorId = D.dr_id  
   LEFT JOIN phr.PatientRepresentatives PR WITH(NOLOCK) ON PPD.PatientRepresentativeId = PR.PatientRepresentativeId  
    WHERE PPD.PatientId = @PatientId AND PPD.PatientPortalDocumentId=@PatientPortalDocumentId
END  
  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
