SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	29-November-2016
Description			:	Approve prescription discharge request
Last Modified By	:	Prabhash H
Last Modifed Date	:	12-October-2017
=======================================================================================
*/

CREATE PROCEDURE [dbo].[ApprovePrescriptionDischargeRequest]   
	@discharge_request_id	BIGINT,   
	@created_by				BIGINT,  
	@doctorId				BIGINT,  
	@discharge_reason		VARCHAR(MAX) = NULL    
AS  
BEGIN  
   
	DECLARE @pres_id  BIGINT  
	DECLARE @prescribing_authority BIGINT   
 
	SELECT TOP 1 @pres_id =pres_id,@discharge_reason=ISNULL(@discharge_reason,discharge_reason)
	FROM  prescription_discharge_requests  WITH(NOLOCK)
	WHERE discharge_request_id = @discharge_request_id 	 
	   
	SELECT TOP 1 @prescribing_authority = prescribing_authority 
	FROM doctors WITH(NOLOCK) WHERE dr_id=@created_by  
	   
	IF @prescribing_authority>=3 -- Automatic approval of discharge request  
		BEGIN  
		
			UPDATE pd  SET HISTORY_ENABLED = 0, discharge_desc=@discharge_reason, discharge_date=GETDATE(), discharge_dr_id=@doctorId 
			FROM prescription_details pd WITH(NOLOCK) 
			WHERE pd.PRES_ID = @pres_id
		
	    
			UPDATE pda SET HISTORY_ENABLED = 0, discharge_desc=@discharge_reason, discharge_date=GETDATE(), discharge_dr_id=@doctorId 
			FROM prescription_details_archive pda WITH(NOLOCK)
			WHERE pda.PRES_ID = @pres_id 

			UPDATE prescription_discharge_requests   
			SET approved_by = @created_by , approved_on = GETDATE()   
			WHERE  pres_id = @pres_id AND is_active=1
		 
		END  
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
