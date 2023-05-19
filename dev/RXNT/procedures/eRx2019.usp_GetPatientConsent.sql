SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Rasheed  
-- Create date: 02-March-2019
-- Description: Get Patient Consent for the user  
-- =============================================  
  
CREATE PROCEDURE [erx2019].[usp_GetPatientConsent]  
 @PatientId BIGINT,  
 @DoctorCompanyId BIGINT,
 @LoggedInUserId BIGINT  
AS  
BEGIN  
 SELECT TOP 1 pa_id PatientId, dr_id DoctorId, date ConsentDate  
 FROM patient_consent WITH(NOLOCK)   
 WHERE pa_id =@PatientId AND dr_id = @LoggedInUserId  
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
