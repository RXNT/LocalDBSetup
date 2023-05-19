SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
 
-- =============================================  
-- Author:  Vinod  
-- Create date: 03-April-2020
-- Description: Get SPO ReferenceId
-- =============================================  

CREATE PROCEDURE [spe].[usp_GetSPOReferenceId]  -- 123
 @RxDetailId BIGINT,
 @RxId BIGINT


AS  
BEGIN  

SELECT TOP 1 spo_ir_id SPOReferenceId from [spe].[SPEMessages] WITH(NOLOCK) where pres_id = @RxId and pd_id = @RxDetailId


 
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
