SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 20-FEB-2016
-- Description:	to create a new RxNT Encounter Template
-- =============================================
CREATE PROCEDURE [enc].[usp_SaveRxNTEncounterTemplate]
(
	@TemplateId					INT OUTPUT,
	@EncounterId				INT,
	@TemplateName				VARCHAR(75),
	@TranStatus					BIT OUTPUT,
	@DoctorId					BIGINT,
	@AddedByDrId				BIGINT,
	@EncTextXML					NTEXT,
	@CC							NVARCHAR(1024)=NULL,
	@LastModifiedDate			DATETIME,
	@LastModifiedBy				INT,
	@EncTextJSON				NVARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;
	SET @TranStatus = 1
	BEGIN TRY
		SET XACT_ABORT ON
		BEGIN TRANSACTION 
			IF ISNULL(@TemplateId,0) = 0
				BEGIN
					SET @TemplateId = -1
					INSERT INTO [enchanced_encounter_templates] 
					([dr_id],
					[enc_text],
					[chief_complaint],
					[enc_name],
					[enc_json]) 
					VALUES(
					@DoctorId,
					@EncTextXML,
					ISNULL(@CC,''),
					@TemplateName,
					@EncTextJSON
					)
					SET @TemplateId =  SCOPE_IDENTITY();
				END
			ELSE 
				BEGIN
					UPDATE [enchanced_encounter_templates] 
					SET 
						[enc_text]=@EncTextXML,
						[chief_complaint]=ISNULL(@CC,''),
						[enc_name]=@TemplateName,
						[enc_json]=@EncTextJSON
					WHERE enc_tmpl_id=@TemplateId
				END
			
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		DECLARE @bkErrorMessage AS NVARCHAR(4000),@bkErrorSeverity AS INT,@bkErrorState AS INT;
		SELECT 
			@bkErrorMessage = ERROR_MESSAGE(),
			@bkErrorSeverity = ERROR_SEVERITY(),
			@bkErrorState = ERROR_STATE();
		RAISERROR (@bkErrorMessage, -- Message text.
				   @bkErrorSeverity, -- Severity.
				   @bkErrorState -- State.
				   );
		SET @TranStatus = 0
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
			VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),
			'EHR','CREATE ENCOUNTER TEMPLATE','EncounterId:'+CONVERT(VARCHAR(500),@EncounterId)+',Doctor Id:'+CONVERT(VARCHAR(500),@DoctorId),ERROR_LINE ())
			   
	  END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
