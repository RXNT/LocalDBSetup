SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
    
/*     
=======================================================================================    
Author    : Rasheed    
Create date   : 19-December-2019    
Description   : Get Patient Document Details by Id    
Last Modified By :    
Last Modifed Date :    
=======================================================================================    
*/    
CREATE     PROCEDURE [ehr].[usp_GetPatientDocumentById]
(     
 @PatientId  INT,    
 @DocumentId BIGINT     
)    
AS    
BEGIN    
 SELECT PD.document_id,PD.pat_id,PD.src_dr_id,PD.upload_date,    
 D.dr_last_name + '' + D.dr_first_name as DoctorName,    
 PD.title,PD.description,    
 PD.filename,PD.cat_id,PD.owner_id,PD.owner_type,PD.active,PD.comment   
 FROM patient_documents PD WITH (NOLOCK)    
 INNER JOIN dbo.doctors D WITH(NOLOCK) ON PD.src_dr_id = D.dr_id    
    WHERE PD.pat_id = @PatientId AND PD.document_id=@DocumentId    
END    
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
