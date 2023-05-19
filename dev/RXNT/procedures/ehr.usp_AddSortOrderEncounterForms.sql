SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Sheik
-- Create date: 07-Apr-2020
-- Description:	To save Order encounter forms
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_AddSortOrderEncounterForms]
	@DoctorId BIGINT,
	@FormId BIGINT,
	@SortOrder BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT TOP 1 1 FROM [encounter_form_settings] WITH(NOLOCK) WHERE DR_ID = @DoctorId AND enc_type_id = @FormId)
	 BEGIN
		UPDATE [encounter_form_settings] SET sort_order = @SortOrder
		WHERE DR_ID = @DoctorId AND enc_type_id = @FormId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
