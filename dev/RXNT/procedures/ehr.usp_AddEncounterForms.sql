SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		SHEIK
-- Create date: 17-APR-2020
-- Description:	To add the encounter forms
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_AddEncounterForms]
	@DoctorId	BIGINT,
	@FormId		BIGINT,
	@Type		VARCHAR(125),
	@Name		VARCHAR(125),
	@SortIrder	BIGINT
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
			name,
			sort_order
		) 
		VALUES
		(
			@DoctorId,
			@Type,
			GETDATE(),
			@Name,
			@SortIrder
		)
		
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
