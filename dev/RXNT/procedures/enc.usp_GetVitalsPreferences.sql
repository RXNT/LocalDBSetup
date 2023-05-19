SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To get the vitals preferences settings for the doctor
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetVitalsPreferences]
	@DoctorId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT fav.[vitalsId],vit.[vitalsText],fav.[vitalsCheck] 
	FROM doc_fav_vitals fav INNER JOIN doc_vitalsList vit ON vit.[vitalsId]= fav.[vitalsId] 
	WHERE fav.docId = @DoctorId 
	ORDER BY OrderIndex 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
