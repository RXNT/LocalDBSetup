SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 28-Jan-2016
-- Description:	To add the encounter forms
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_AddEncounterForms]
	@DoctorId	BIGINT,
	@FormId		BIGINT,
	@Type		VARCHAR(125),
	@Name		VARCHAR(125)
AS

BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS( SELECT TOP 1 1 FROM encounter_form_settings WHERE dr_id = @DoctorId AND type = @type )
	BEGIN
		INSERT INTO encounter_form_settings
		( 
			dr_id,
			type,
			date_added,
			name
		) 
		VALUES
		(
			@DoctorId,
			@Type,
			GETDATE(),
			@Name
		)
		
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
