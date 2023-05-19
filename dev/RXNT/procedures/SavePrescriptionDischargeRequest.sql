SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	29-November-2016
Description			:	Save prescription discharge request
Last Modified By	:	Prabhash H
Last Modifed Date	:	12-October-2017
=======================================================================================
*/

CREATE PROCEDURE [dbo].[SavePrescriptionDischargeRequest]	
	@pres_id			BIGINT, 
	@created_by 		BIGINT,
	@doctorId			BIGINT,
	@discharge_reason	VARCHAR(MAX) = NULL
AS
BEGIN 
	
	DECLARE @discharge_request_id  BIGINT
	DECLARE @prescribing_authority BIGINT  
	
	INSERT INTO prescription_discharge_requests(pres_id,created_by,created_on,is_active,discharge_reason,requested_to)
	VALUES(@pres_id,@created_by,GETDATE(),1,@discharge_reason,@doctorId)
	SET @discharge_request_id  = SCOPE_IDENTITY()
	
	SELECT TOP 1 @prescribing_authority = prescribing_authority 
	FROM doctors WITH(NOLOCK) 
	WHERE dr_id=@created_by
	
	IF @prescribing_authority>=3 -- Automatic approval of discharge request
		BEGIN
		
			UPDATE prescription_details 
			SET HISTORY_ENABLED = 0, discharge_desc=@discharge_reason, discharge_date=getdate(), discharge_dr_id=@doctorId 
			WHERE PRES_ID = @pres_id
		
			UPDATE prescription_details_archive 
			SET HISTORY_ENABLED = 0, discharge_desc=@discharge_reason, discharge_date=getdate(), discharge_dr_id=@doctorId 
			WHERE PRES_ID = @pres_id
			
			UPDATE prescription_discharge_requests
			SET approved_by = @created_by , approved_on = GETDATE() 
			WHERE pres_id = @pres_id AND is_active=1

		END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
