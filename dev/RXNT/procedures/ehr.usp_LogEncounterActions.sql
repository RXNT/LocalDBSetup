SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Samip Neupane>
-- Create date: <06/29/2021>
-- Description:	<Log Deleted Encounters>
-- =============================================
CREATE PROCEDURE [ehr].[usp_LogEncounterActions] 
	@PatientId				BIGINT,
	@EncounterId			BIGINT,
	@AddedByDrId			BIGINT,
	@ActionDoctorId			BIGINT,
	@ActionId				BIGINT,
	@EncounterDate			DateTime,
	@ActionDate				DATETIME,
	@ExternalEncounterId	VARCHAR(250),
	@Comments				NVARCHAR(MAX),
	@IsSigned				BIT,
	@SmartFormId			VARCHAR(50),
	@EncounterVersion		VARCHAR(1024)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO dbo.enchanced_encounter_log
	(
		enc_id,
		dr_id,
		patient_id,
		enc_date,
		action_id,
		action_date,
		action_dr_id,
		type,
		external_encounter_id,
		comments,
		is_signed,
		smart_form_id

	) values 
	(
		@EncounterId,
		@AddedByDrId,
		@PatientId,
		@EncounterDate,
		@ActionId,
		@ActionDate,
		@ActionDoctorId,
		ISNULL(@EncounterVersion, ''),
		@ExternalEncounterId,
		@Comments,
		@IsSigned,
		@SmartFormId
	)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
