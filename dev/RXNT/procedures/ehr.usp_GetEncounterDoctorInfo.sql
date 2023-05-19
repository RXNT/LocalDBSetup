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
CREATE PROCEDURE [ehr].[usp_GetEncounterDoctorInfo]
	@DoctorId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT dr_id,manual_encounter_forms_sort,show_encounter_forms_sort_message FROM doctor_info WITH(NOLOCK) WHERE dr_id = @DoctorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
