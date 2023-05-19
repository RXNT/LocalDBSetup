SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
  
  
  
        
  
CREATE PROCEDURE [eRx2019].[usp_UpdateRxChangeResponseType]   
 @RxId BIGINT,  
 @RxChangeResponseType  INT  
AS  
BEGIN  
      
    DECLARE @enParticipant    BIGINT=262144,  
    @version VARCHAR(200) =  'v6.1'  
     
    IF @RxChangeResponseType = 10 --RxChangeChanged  
    BEGIN  
		UPDATE erx.RxChangeRequests    
		SET ResponseType = 10   
		WHERE presid = @RxId  
	END  
    ELSE IF @RxChangeResponseType = 100 --RxChangeChanged  
	BEGIN  
		UPDATE erx.RxChangeRequests  SET responsetype = 100 WHERE presid = @RxId  
	END  
END  
  
                             
                          
  
  
  
  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
