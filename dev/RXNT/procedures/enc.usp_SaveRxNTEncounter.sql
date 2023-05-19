SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Thomas K
-- Create date: 02-FEB-2016
-- Description:	to create a new RxNT Encounter
-- =============================================
CREATE PROCEDURE [enc].[usp_SaveRxNTEncounter]
(
	@EncounterId				INT OUTPUT,
	@TranStatus					BIT OUTPUT,
	@PatientId					BIGINT,
	@DrId						BIGINT,
	@AddedByDrId				BIGINT,
	@EncDate					DATETIME,
	@EncTextXML					NTEXT,
	@CC							NVARCHAR(1024),
	@type						VARCHAR(1024),
	@IsSigned					BIT,
	@dtSigned					DATETIME,
	@CaseId						INT,
	@LocationId					INT,
	@LastModifiedDate			DATETIME,
	@LastModifiedBy				INT,
	@DataSetsSelection			VARCHAR(50),
	@TypeOfVisit				CHAR(10),
	@VisitId					BIGINT,
	@Active						BIT,
	@EncTextJSON				NVARCHAR(MAX),
	@EncounterName				NVARCHAR(1024),
	@EnableEncounterLog			BIT
)
AS
BEGIN
	SET NOCOUNT ON;
	SET @TranStatus = 1
	SET @EncounterId = -1
	BEGIN TRY
		SET XACT_ABORT ON
		BEGIN TRANSACTION 
			INSERT INTO [enchanced_encounter] 
			([patient_id],
			[dr_id],
			[added_by_dr_id],
			[enc_date],
			[enc_text],
			[chief_complaint],
			[type],
			[issigned],
			dtsigned,
			[last_modified_by],
			[type_of_visit],
			[encounter_version],
			[enc_name]) 
			VALUES(
			@PatientId,
			@DrId,
			@AddedByDrId,
			@EncDate,
			@EncTextXML,
			@CC,
			@type,
			@IsSigned,
			@dtSigned,
			@LastModifiedBy,
			@TypeOfVisit,
			'v1.1',
			@EncounterName
			)
			SET @EncounterId =  SCOPE_IDENTITY();
			IF(@EncounterId > 0)
			BEGIN
				INSERT INTO enchanced_encounter_additional_info 
				([enc_id],
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
				[type_of_visit]) 
				VALUES(
				@EncounterId,
				@PatientId,
				@DrId,
				@AddedByDrId,
				@EncDate,
				@EncTextJSON,
				@CC,
				@type,
				@IsSigned,
				@dtSigned,
				@LastModifiedBy,
				@TypeOfVisit
				)
				
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
				ELSE IF EXISTS(SELECT TOP 1 * FROM patient_visit WITH(NOLOCK) WHERE enc_id=@EncounterId AND pa_id = @PatientId)
				BEGIN
					UPDATE patient_visit 
					SET enc_id=0 
					WHERE  enc_id=@EncounterId AND pa_id = @PatientId
				END
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
			'EHR','CREATE RxNT ENCOUNTER','PatientId:'+CONVERT(VARCHAR(500),@PatientId)+',Doctor Id:'+CONVERT(VARCHAR(500),@DrId),ERROR_LINE ())
			   
	  END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
