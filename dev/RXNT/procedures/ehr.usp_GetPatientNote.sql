SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 04-Jul-2016
-- Description:	To Get Patient Note
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPatientNote]
	@NoteId BIGINT
AS
BEGIN
 SELECT *
 FROM vwPatientNotes WITH(NOLOCK)
 WHERE note_id = @NoteId 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
