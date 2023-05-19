SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Sheik
-- Create date: 13-Apr-2020
-- Description:	To save Order encounter forms
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveManualEncounterFormStatus]
	@DoctorId BIGINT,
	@ManualOrder BIT,
	@ShowAlert BIT
AS

BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT TOP 1 1 FROM doctor_info WITH(NOLOCK) WHERE dr_id = @DoctorId)
	 BEGIN
		UPDATE [doctor_info] SET manual_encounter_forms_sort = @ManualOrder, show_encounter_forms_sort_message = @ShowAlert
		WHERE dr_id = @DoctorId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
