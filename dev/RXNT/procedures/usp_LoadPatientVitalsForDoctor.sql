SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 24-May-2016
-- Description:	Load Patient Vitals For Doctor (Favourites)
-- =============================================

CREATE PROCEDURE [dbo].[usp_LoadPatientVitalsForDoctor]
(
	@DoctorId BIGINT
)
AS
BEGIN
	SELECT 
	fav.[vitalsId],vit.[vitalsText],fav.[vitalsCheck] 
	FROM doc_fav_vitals fav WITH(NOLOCK)
	INNER JOIN doc_vitalsList vit WITH(NOLOCK) ON vit.[vitalsId]= fav.[vitalsId] 
	WHERE fav.docId = @DoctorId 
	ORDER BY OrderIndex
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
