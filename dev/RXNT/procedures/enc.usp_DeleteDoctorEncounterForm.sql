SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 28-Jan-2016
-- Description:	To get the encounter forms
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_DeleteDoctorEncounterForm]
	@DoctorId BIGINT,
	@FormId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	 
	DELETE 
	FROM [encounter_form_settings] 
	WHERE ENC_TYPE_ID = @FormId AND DR_ID = @DoctorId 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
