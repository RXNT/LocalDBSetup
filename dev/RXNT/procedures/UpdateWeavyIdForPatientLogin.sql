SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Michael Cheever
-- Create date: 6/3/2022
-- Description:	Update the patient login with the new weavy id
-- =============================================

CREATE   PROC [dbo].[UpdateWeavyIdForPatientLogin](
	@LoginId BIGINT,
	@WeavyId BIGINT = NULL
)
AS
BEGIN
	UPDATE [RXNT].[dbo].[patient_login]	
	SET	[WeavyId] = @WeavyId
	WHERE [pa_login_id] = @LoginId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
