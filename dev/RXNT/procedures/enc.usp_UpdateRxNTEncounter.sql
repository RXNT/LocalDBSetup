SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Thomas K
-- Create date: 02-FEB-2016
-- Description:	to update exisitng Encounter
-- =============================================
CREATE PROCEDURE [enc].[usp_UpdateRxNTEncounter]
(
	@EncounterId				INT,
	@TranStatus					BIT OUTPUT,
	@PatientId					BIGINT,
	@DrId						BIGINT,
	@EncDate					DATETIME,
	@EncTextXML					NTEXT,
	@CC							NVARCHAR(1024),
	@IsSigned					BIT,
	@dtSigned					DATETIME,
	@LastModifiedDate			DATETIME,
	@LastModifiedBy				INT,
	@TypeOfVisit				CHAR(10),
	@VisitId					BIGINT,
	@EncTextJSON				NVARCHAR(MAX),
	@type						VARCHAR(1024),
	@EnableEncounterLog			BIT,
	@IsAmended					BIT = 0,
	@EncounterName				NVARCHAR(1024)
)
AS
BEGIN
	DECLARE @IsValid AS BIT
	SET NOCOUNT ON;
	SET @TranStatus = 1
	BEGIN TRY
		SET XACT_ABORT ON
		BEGIN TRANSACTION 
			IF NOT EXISTS(SELECT TOP 1 1 FROM enchanced_encounter_additional_info
			WHERE enc_id= @EncounterId 
				and patient_id=@PatientId)
			BEGIN
				
				DECLARE @enc_xml NVARCHAR(MAX) 
				SELECT @enc_xml = [enc_text] FROM [enchanced_encounter] 
				WHERE enc_id= @EncounterId 
				and patient_id=@PatientId
				
				IF(@EnableEncounterLog=1)
				BEGIN
					INSERT INTO enchanced_encounter_log 
					(
						[enc_id],
						[type],
						[patient_id],
						[dr_id],
						[enc_xml],
						[enc_json],
						[created_on],
						[created_by]
					)
					VALUES
					(
						@EncounterId,
						@type,
						@PatientId,
						@DrId,
						@enc_xml,
						NULL,
						GETDATE(),
						@LastModifiedBy
					)
				END
				
				INSERT INTO enchanced_encounter_additional_info 
				(
					[enc_id],
					[patient_id],
					[dr_id],
					[added_by_dr_id],
					[enc_date],
					[JSON],
					[chief_complaint],
					[type],
					[issigned],
					dtsigned,
					[last_modified_by],
					[type_of_visit]
				) 
				VALUES(
					@EncounterId,
					@PatientId,
					@DrId,
					@LastModifiedBy,
					@EncDate,
					@EncTextJSON,
					@CC,
					@type,
					@IsSigned,
					@dtSigned,
					@LastModifiedBy,
					@TypeOfVisit
				) 
			END
			ELSE
			BEGIN
				UPDATE enchanced_encounter_additional_info 
				SET 
				[JSON] = @EncTextJSON,
				dtsigned=@dtSigned, 
				issigned=@IsSigned, 
				dr_id=@drid, 
				enc_date = @EncDate, 
				chief_complaint=@CC, 
				last_modified_by=@LastModifiedBy, 
				type_of_visit=@TypeOfVisit 
				WHERE 
					enc_id= @EncounterId 
					and patient_id=@PatientId
			END
			
			UPDATE [enchanced_encounter] 
				SET 
				[enc_text] = @EncTextXML,
				dtsigned=@dtSigned, 
				issigned=@IsSigned, 
				dr_id=@drid, 
				enc_date = @EncDate, 
				chief_complaint=@CC, 
				last_modified_by=@LastModifiedBy, 
				type_of_visit=@TypeOfVisit,
				is_amended=@IsAmended,
				enc_name=@EncounterName
				WHERE 
					enc_id= @EncounterId 
					and patient_id=@PatientId
					
			IF(@EnableEncounterLog=1)
			BEGIN
			INSERT INTO enchanced_encounter_log 
				(
					[enc_id],
					[type],
					[patient_id],
					[dr_id],
					[enc_xml],
					[enc_json],
					[created_on],
					[created_by]
				)
				VALUES
				(
					@EncounterId,
					@type,
					@PatientId,
					@DrId,
					@EncTextXML,
					@EncTextJSON,
					GETDATE(),
					@LastModifiedBy
				)
				END
				
				IF @VisitId>0
				BEGIN
					UPDATE patient_visit 
					SET enc_id=@EncounterId 
					WHERE visit_id=@VisitId AND pa_id = @PatientId
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
			'EHR','UPDATE RxNT ENCOUNTER','PatientId:'+CONVERT(VARCHAR(500),@PatientId)+',Encounter Id:'+CONVERT(VARCHAR(500),@EncounterId),ERROR_LINE ())
			   
	  END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
