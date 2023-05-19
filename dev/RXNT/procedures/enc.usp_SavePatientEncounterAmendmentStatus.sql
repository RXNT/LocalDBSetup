SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Create date: 10/24/2019
-- Description:	Update the amendment status for encouters
-- =============================================
CREATE PROCEDURE [enc].[usp_SavePatientEncounterAmendmentStatus]
	@PatientId		BIGINT,
	@EncounterId	BIGINT,
	@IsAmended		BIT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update enchanced_encounter
	set is_amended = @IsAmended
	where enc_id = @EncounterId AND patient_id = @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
