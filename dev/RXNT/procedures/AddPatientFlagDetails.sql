SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[AddPatientFlagDetails]
(
	@pa_id BIGINT,
	@flagtext VARCHAR(50),
	@dc_id BIGINT,
	@dr_id BIGINT 
)
AS
BEGIN        
		DECLARE @flag_id BIGINT
        IF NOT EXISTS(SELECT TOP 1 1 FROM patient_flags WITH(NOLOCK) WHERE dc_id=@dc_id AND flag_title=@flagtext AND is_enabled=1)
        BEGIN
			INSERT INTO [dbo].[patient_flags]([flag_title],[is_enabled],[dc_id],[hide_on_search])
			VALUES(@flagtext,1,@dc_id,0)
			SET @flag_id=SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
			SELECT TOP 1 @flag_id=flag_id FROM patient_flags WITH(NOLOCK) WHERE dc_id=@dc_id AND flag_title=@flagtext AND is_enabled=1
        END

		IF NOT EXISTS(SELECT TOP 1 1 FROM [dbo].[patient_flag_details] WHERE pa_id=@pa_id AND flag_id=@flag_id AND [active]=1)
		BEGIN 
			INSERT INTO [dbo].[patient_flag_details]([pa_id],[flag_id],[flag_text],[dr_id],[date_added],[active])
			VALUES (@pa_id,@flag_id,@flagtext,@dr_id,GETDATE(),1)
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
