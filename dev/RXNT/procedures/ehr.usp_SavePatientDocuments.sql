SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	07-JULY-2016
Description			:	This procedure is used to save Patient New Documents
Last Modified By	:	Samip Neupane
Last Modifed Date	:	12/29/2022
=======================================================================================
*/
CREATE   PROCEDURE [ehr].[usp_SavePatientDocuments] 
	@DocumentId BIGINT OUTPUT,
	@UploadDate DATETIME,
	@Title VARCHAR(80),
	@Description VARCHAR(225),
	@CategoryId BIGINT,
	@PatientId BIGINT,
	@SourceDoctorId BIGINT,
	@FileName VARCHAR(225),
	@OwnerId BIGINT,
	@OwnerType VARCHAR(3),
	@Comment VARCHAR(500),
	@DocumentDate DATETIME = NULL,
	@EncounterId BIGINT = NULL
AS
BEGIN
	IF ISNULL(@DocumentId, 0) = 0
	BEGIN
		INSERT INTO [patient_documents] (
			[pat_id],
			[src_dr_id],
			[upload_date],
			[title],
			[description],
			[filename],
			[cat_id],
			[owner_id],
			[owner_type],
			[comment],
			[document_date],
			[enc_id]
			)
		VALUES (
			@PatientId,
			@SourceDoctorId,
			@UploadDate,
			@title,
			@Description,
			@filename,
			@CategoryId,
			@ownerid,
			@ownertype,
			@Comment,
			@DocumentDate,
			@EncounterId
			)

		SELECT @DocumentId = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE PATIENT_DOCUMENTS
		SET TITLE = @Title,
			DESCRIPTION = @Description,
			upload_date = @UploadDate,
			[CAT_ID] = @CategoryId,
			comment = @Comment,
			document_date = @DocumentDate,
			enc_id = @EncounterId
		WHERE DOCUMENT_ID = @DocumentId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
