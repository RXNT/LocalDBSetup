SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
-- =============================================  
-- Author:   Rasheed  
-- Create date:  21-Sun-2021
-- Description:  Save Patient EPA  Requests
-- =============================================  
CREATE PROCEDURE [eRx2019].[usp_SavePatientEPARequest]  
 @RelatesToMessageID   VARCHAR(100)=NULL,
 @DoctorCompanyId   BIGINT,  
 @PatientId   BIGINT,
 @DoctorId BIGINT,
 @LoggedInUserId BIGINT,
 @RequestId VARCHAR(50),
 @ResponseId VARCHAR(50),
 @RequestType VARCHAR(50),
 @ResponseType VARCHAR(50)=NULL,
 @PAReferenceID VARCHAR(100),
 @ImmediateResponseId VARCHAR(50)=NULL,
 @Request XML,
 @Response XML = NULL,
 @ImmediateResponse VARCHAR(MAX)=NULL,
 @ResponseCode VARCHAR(10)=NULL
AS  
BEGIN  
	DECLARE @sem_id BIGINT
	INSERT INTO surescripts_epa_messages ([dr_id],
	[prim_dr_id],
	[pa_id],
	[request_id],
	[pa_reference_id],
	[response_id],
	response_code,
	[created_date],
	[response_date],
	[request_type],
	[response_type],
	[immediate_response_id],
	[version],
	[relatesto_message_id])
	VALUES(@DoctorId,@LoggedInUserId,@PatientId,@RequestId,@PAReferenceID,@ResponseId,@ResponseCode,GETDATE(),CASE WHEN @Response IS NULL THEN GETDATE() ELSE NULL END, @RequestType,@ResponseType,@ImmediateResponseId,'v6.1',@RelatesToMessageID)

	SET @sem_id = SCOPE_IDENTITY()
	INSERT INTO [dbo].[surescripts_epa_messages_ex]
           ([sem_id]
           ,[request]
           ,[response]
           ,[immediate_response])
     VALUES
           (@sem_id,
		   @Request,
		   @Response,
           @ImmediateResponse)


	
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
