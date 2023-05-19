SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
                        

CREATE PROCEDURE [eRx2019].[usp_UpdateEnableSurescriptsForDoctor] 
    @EnabledSurescripts    BIT, 
    @DoctorId BIGINT
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @PartnerId INT=262144,  
	@version VARCHAR(50)='v6.1'
	
    Update [dbo].[doctors] SET [ss_enable] = @EnabledSurescripts WHERE dr_id=@DoctorId;
    
    
    Update [dbo].DOC_ADMIN 
    SET REPORT_DATE=GETDATE() 
    WHERE dr_partner_participant=@PartnerId AND DR_ID = @DoctorId;
    
    IF EXISTS(select dr_id from doctor_info WITH(NOLOCK) where dr_id=@DoctorId and is_epcs=1) update doctors set epcs_enabled=1 where dr_id=@DoctorId;
    
		
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
