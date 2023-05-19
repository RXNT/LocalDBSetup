SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author : RAJARAM
-- Create date : 28-OCT-2019
-- Description : To save/update SureScripts Service Level
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveSureScriptsServiceLevel]
(
	@DocotorId BIGINT,
	@SureScriptsPartnerParticipant INT,
	@ServiceLevel SMALLINT,
	@dr_partner_enabled BIT
)
AS
BEGIN
	SET NOCOUNT ON;
	IF @ServiceLevel&2=2/*Refills Enabled*/ AND @ServiceLevel&4=4 /*RxChange not present*/
	BEGIN
		SET @ServiceLevel = @ServiceLevel + 4
	END
	ELSE IF @ServiceLevel&2<>2/*Refills Not Enabled*/ AND @ServiceLevel&4=4 /*RxChange present*/
	BEGIN
		SET @ServiceLevel = @ServiceLevel - 4
	END
	IF EXISTS (SELECT 1 FROM [dbo].[doc_admin] WHERE dr_id = @DocotorId AND [dr_partner_participant] = @SureScriptsPartnerParticipant)
	BEGIN
		UPDATE [dbo].[doc_admin]
		SET dr_service_level = @ServiceLevel,
			dr_partner_enabled = @dr_partner_enabled,
			[update_date] = GETDATE()
		WHERE dr_id = @DocotorId AND [dr_partner_participant] = @SureScriptsPartnerParticipant
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[doc_admin]
           ([dr_id]
           ,[dr_partner_participant]
           ,[dr_service_level]
           ,[dr_partner_enabled]
           ,[report_date]
           ,[update_date]
           ,[version])
		 VALUES
			   (@DocotorId
			   ,@SureScriptsPartnerParticipant
			   ,@ServiceLevel
			   ,@dr_partner_enabled
			   ,GETDATE()
			   ,GETDATE()
			   ,'10.6')
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
