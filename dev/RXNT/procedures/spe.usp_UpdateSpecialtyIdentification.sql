SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Vinod  
-- Create date: 17-April-2020
-- Description: Update Specialty Identification
-- =============================================  
  
CREATE PROCEDURE [spe].[usp_UpdateSpecialtyIdentification]  
 @RxDetailid BIGINT,
 @RxId BIGINT,
 @NDC VARCHAR(20),
 @IsSpecialty BIT=NULL,
 @ResponseMessage VARCHAR(2000),
 @IsSuccess  BIT=NULL

AS  
BEGIN  
 UPDATE prescription_details set is_specialty = @IsSpecialty  where pd_id = @RxDetailid
 IF @IsSpecialty IS NOT NULL AND ISNULL(@IsSuccess,0)=1
 BEGIN
	INSERT INTO [spe].[SurescriptsSpecialtyIdentificationDetails]  (NDC,IsSpecialty,PerformedOn)
	VALUES(@NDC,@IsSpecialty,GETDATE())
 END
 INSERT INTO [spe].[SPEMessages] (pres_id,pd_id,queued_date,is_success,message_type,response_message) VALUES (@RxId,@RxDetailId,GETDATE(),ISNULL(@IsSuccess,0),1,@ResponseMessage)
END   
  

 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
