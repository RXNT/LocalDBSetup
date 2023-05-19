SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		RAJARAM GANJIKUNTA
-- Create date: 21-Aug-2017
-- Description:	to create/update a Patient Encounter V2.0
-- Modified By		:Rasheed
-- Modified date	:31-Oct-2022
-- Description		:	to save the encountertype(single/multi sign) and multisignature status
-- =============================================

CREATE   PROCEDURE [enc].[usp_SavePatientEncounterV2]
(
	@EncounterId				INT OUTPUT,
	@PatientId					BIGINT,
	@DrId						BIGINT,
	@AddedByDrId				BIGINT,
	@EncDate					DATETIME,
	@ChiefComplaint				NVARCHAR(1024) = NULL,
	@IsSigned					BIT,
	@SignedDate					DATETIME = NULL,
	@LastModifiedDate			DATETIME,
	@LastModifiedBy				INT ,
	@EncounterNoteTypeCode				CHAR(10) = NULL,
	@EncounterVersion			VARCHAR(10),
	@ExternalEncounterId		VARCHAR(250),
	@VisitId					BIGINT = NULL,
	@EncounterName				NVARCHAR(1024) = NULL,
	@IsMultiSignature			BIT = NULL,
	@IsInReview			BIT = NULL,
	@SmartFormId				VARCHAR(50) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @TypeOfVisit VARCHAR(10)=@EncounterNoteTypeCode
		DECLARE @EncounterNoteTypeId BIGINT
		SELECT @EncounterNoteTypeId = ent.Id 
		FROM enc.EncounterNoteType ent WITH(NOLOCK) 
		WHERE ent.Code = @EncounterNoteTypeCode AND ent.Active = 1
		 
		SET @TypeOfVisit = CASE WHEN @EncounterNoteTypeCode = 'OFFICE' THEN @EncounterNoteTypeCode ELSE 'OTHER' END
		IF ISNULL(@EncounterId, 0) = 0
		BEGIN
			INSERT INTO [dbo].[enchanced_encounter]
			   ([patient_id]
			   ,[dr_id]
			   ,[added_by_dr_id]
			   ,[enc_date]
			   ,[chief_complaint]
			   ,[issigned]
			   ,[dtsigned]
			   ,[type_of_visit]
			   ,[type]
			   ,[active]
			   ,[encounter_version]
			   ,external_encounter_id
			   ,last_modified_date
			   ,[enc_name]
			   ,[is_multisignature]
			   ,[is_inreview]
			   ,[smart_form_id]
			   ,EncounterNoteTypeId
			   )
			VALUES
			   (@PatientId
			   ,@DrId
			   ,@AddedByDrId
			   ,@EncDate
			   ,@ChiefComplaint
			   ,@IsSigned
			   ,@SignedDate
			   ,@TypeOfVisit
			   ,''
			   ,1
			   ,@EncounterVersion
			   ,@ExternalEncounterId
			   ,@LastModifiedDate
			   ,@EncounterName
			   ,@IsMultiSignature
			   ,@IsInReview
			   ,@SmartFormId
			   ,@EncounterNoteTypeId
			   )
			   
			SELECT @EncounterId = SCOPE_IDENTITY()
	   END
	   ELSE
	   BEGIN
			UPDATE [dbo].[enchanced_encounter]
			SET [patient_id] = @PatientId,
			    [dr_id] = @DrId,
			    [enc_date] = @EncDate,
			    [chief_complaint] = @ChiefComplaint,
			    [issigned] = @IsSigned,
			    [dtsigned] = @SignedDate,
			    [type_of_visit] = @TypeOfVisit,
			    [encounter_version] = @EncounterVersion,
			    [last_modified_date] = @LastModifiedDate,
			    [last_modified_by] = @LastModifiedBy, 
				[enc_name] = @EncounterName,
				[is_multisignature] = @IsMultiSignature,
				[is_inreview] =@IsInReview,
				[smart_form_id] =ISNULL(@SmartFormId,[smart_form_id]),
				[EncounterNoteTypeId] = @EncounterNoteTypeId
			WHERE enc_id = @EncounterId
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
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
			VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),
			'EHR','CREATE/UPDATE PATIENT V2 ENCOUNTER','PatientId:'+CONVERT(VARCHAR(500),@PatientId)+',Doctor Id:'+CONVERT(VARCHAR(500),@DrId),ERROR_LINE ())
	  END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
