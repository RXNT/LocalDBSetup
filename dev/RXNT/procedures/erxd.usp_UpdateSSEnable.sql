SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
                        

CREATE PROCEDURE [erxd].[usp_UpdateSSEnable] 
    @enParticipant  BIGINT,
    @ss_enable    BIT,
    @version VARCHAR(200),
    @doctor_id BIGINT
AS
BEGIN
    SET NOCOUNT ON
    Update [dbo].[doctors] SET [ss_enable] = @ss_enable WHERE dr_id=@doctor_id;
    
    
    Update [dbo].DOC_ADMIN 
    SET REPORT_DATE=GETDATE() 
    WHERE 
		dr_partner_participant=@enParticipant AND version=@version  AND DR_ID = @doctor_id;
    
    IF EXISTS(select dr_id from doctor_info where dr_id=@doctor_id and is_epcs=1) update doctors set epcs_enabled=1 where dr_id=@doctor_id;
    
		
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
