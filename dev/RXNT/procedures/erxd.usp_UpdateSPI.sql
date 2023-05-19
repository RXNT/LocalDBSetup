SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [erxd].[usp_UpdateSPI] 
    @spiid  VARCHAR(200),
    @enParticipant    BIGINT,
    @version VARCHAR(200),
    @drid BIGINT
AS
BEGIN
    SET NOCOUNT ON
    Update [dbo].[doctors] SET [spi_id] = @spiid WHERE dr_id= @drid;
    
    Update [dbo].DOC_ADMIN 
    SET 
    REPORT_DATE=GETDATE() 
    WHERE dr_partner_participant= @enParticipant AND version=@version  AND DR_ID = @drid
		
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
