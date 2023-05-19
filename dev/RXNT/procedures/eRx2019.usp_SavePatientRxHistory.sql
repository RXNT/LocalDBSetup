SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
-- =============================================  
-- Author:   Rasheed  
-- Create date:  02-Mar-2020
-- Description:  Save Patient Rx History Request
-- =============================================  
CREATE PROCEDURE [eRx2019].[usp_SavePatientRxHistory]  
 @RelatesToMessageID   VARCHAR(100)=NULL,
 @DoctorCompanyId   BIGINT,  
 @PatientId   BIGINT,
 @DoctorId BIGINT,
 @LoggedInUserId BIGINT,
 @RequestId VARCHAR(50),
 @ImmediateResponseId VARCHAR(50)=NULL,
 @StartDate DATETIME,
 @EndDate DATETIME,
 @Request XML,
 @ImmediateResponse VARCHAR(MAX)=NULL
AS  
BEGIN  
   
	INSERT INTO surescript_medHx_messages (drid,patientid,requestid,startdate,enddate,request,version,createddate,immediate_response_id,immediate_response,prim_dr_id,relatesto_message_id)
	VALUES(@DoctorId,@PatientId,@RequestId,@StartDate,@EndDate,@Request,'v6.1',GETDATE(),@ImmediateResponseId,@ImmediateResponse,@LoggedInUserId,@RelatesToMessageID)
   
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
