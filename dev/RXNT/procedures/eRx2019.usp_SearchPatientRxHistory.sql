SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
-- =============================================  
-- Author:   Rasheed  
-- Create date:  02-Mar-2020
-- Description:  Search Patient ClaimsHx from past 24 hrs  
-- =============================================  
CREATE PROCEDURE [eRx2019].[usp_SearchPatientRxHistory]--[eRx2019].[usp_SearchPatientRxHistory] 2824, 65639512 ,117936
 @DoctorCompanyId   BIGINT,  
 @PatientId   BIGINT,
 @LoggedInUserId BIGINT
AS  
BEGIN  
   
  SELECT Response,StartDate,EndDate,requestid,ResponseId,immediate_response ImmediateResponse
  FROM surescript_medHx_messages WITH(NOLOCK) 
  WHERE patientid=@PatientId AND   
  DATEDIFF(HOUR,createddate,GETDATE()) <=24 AND  
  version='v6.1'  
   
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
