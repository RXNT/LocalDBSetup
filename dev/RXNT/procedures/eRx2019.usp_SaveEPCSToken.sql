SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	07-Oct-2019
Description			:	This procedure is used to get save active token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [eRx2019].[usp_SaveEPCSToken] --11647,100,0
	@Action VARCHAR(10)=NULL,
	@DoctorId	BIGINT,
	@Comments VARCHAR(4000)=NULL
AS
BEGIN
	/*
	Status List
	Requested = 0,//enIDProofCompleted = 0,
    Completed = 1,//enTokenSetupCompleted = 1,
    //TokenBillingCompleted = 2,
    //TokenShipped = 3,
    Cancelled = 4,//enTokenShipVoided
    Deactivated = 5,
    Processed = 6, //NEW
    None = -1,
    //SoftTokenInitiated = 99,
    //SoftTokenAssigned = 100,
    //enExperianSuccess = 101
    */
    IF LEN(@Comments)>0
		SET @Comments = '<br/>(' + convert(varchar(20),getdate(),120)+ ')' + @Comments
	ELSE
		SET @Comments=NULL
		
     
	IF @Action='ACTIVATED'
    BEGIN 
		UPDATE doc_token_info SET stage=1,is_activated=1,last_edited_by=1,last_edited_on=GETDATE() 
		WHERE [token_type] IN (1,2) 
		AND ISNULL([is_activated],0)!=1
		AND stage IN (6) 
		AND dr_id=@DoctorId
		UPDATE doctors 
		SET epcs_enabled=1
		WHERE dr_id=@DoctorId
		UPDATE doc_admin
		SET dr_service_level=dr_service_level|2048
		WHERE dr_id=@DoctorId AND dr_partner_participant=262144
	END 
	ELSE IF @Action='FAILED'
    BEGIN 
		UPDATE doc_token_info SET stage=7,comments=ISNULL(@Comments,comments),last_edited_by=1,last_edited_on=GETDATE() 
		WHERE [token_type] IN (1,2) 
		AND ISNULL([is_activated],0)!=1
		AND stage IN (6) 
		AND dr_id=@DoctorId
	END 
    
    SELECT @DoctorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
