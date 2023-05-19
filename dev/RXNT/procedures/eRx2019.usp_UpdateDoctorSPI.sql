SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_UpdateDoctorSPI] 
 @Doctorid BIGINT,
 @SPI  VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON
    
    DECLARE @enParticipant    BIGINT=262144,
    @version VARCHAR(200) =  'v6.1'
   
    
    Update [dbo].[doctors] SET [spi_id] = @SPI,ss_enable=1 WHERE dr_id= @Doctorid;
    
    Update [dbo].DOC_ADMIN 
    SET 
    REPORT_DATE=GETDATE() 
    WHERE dr_partner_participant= @enParticipant AND DR_ID = @Doctorid
		
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
