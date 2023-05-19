SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
 
-- =============================================  
-- Author:  Vinod  
-- Create date: 03-April-2020
-- Description: Get Patient Medication Details
-- =============================================  

CREATE PROCEDURE [fhir].[usp_GenerateAuthorizationToken]  -- 123
 @MutuallyDefined VARCHAR(50) = NULL

AS  
BEGIN  
if exists(select * from patients_coverage_info where transaction_message_id = @MutuallyDefined)
BEGIN 

INSERT INTO [fhir].[authorization_tokens]
(relates_to_message_id,authorization_token,created_on)
VALUES (@MutuallyDefined,newid(),GETDATE())

SELECT * from [fhir].[authorization_tokens] where id = SCOPE_IDENTITY();

END
 
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
