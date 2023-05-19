SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 31-May-2016
-- Description:	Delete Patient Vitals
-- =============================================

CREATE PROCEDURE [dbo].[usp_DeletePatientVitals]
(
	@PatientVitalsId INT,
	@PatientId INT
)
AS
BEGIN
	DELETE FROM PATIENT_VITALS 
	WHERE PA_ID=@PatientId AND PA_VT_ID = @PatientVitalsId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
