SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
-- =============================================  
-- Author:   Rasheed  
-- Create date:  02-Mar-2020
-- Description:  Save Patient Rx History Request
-- =============================================  
CREATE PROCEDURE [eRx2019].[usp_SavePatientRxHistoryResponse]  
 @MessageID   VARCHAR(100),  
 @RelatesToMessageID   VARCHAR(100),  
 @From   VARCHAR(100),  
 @To   VARCHAR(100),  
 @Response  XML,
 @EffectiveStartDate DATETIME,
 @EffectiveEndDate DATETIME
AS  
BEGIN  
   
	UPDATE surescript_medHx_messages SET responseid=@MessageID, response=@Response,response_date=GETDATE(),effective_end_date=@EffectiveEndDate
	WHERE requestid=@RelatesToMessageID 
   
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
