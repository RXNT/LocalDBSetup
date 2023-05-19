SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 31-OCT-2016
-- Description:	To get the patient Social Hx Smoking Status
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatientSocialHxSmokingStatus]
	@PatientId BIGINT,
	@PatientFlagDetailId BIGINT
AS

BEGIN
	DELETE FROM dbo.patient_flag_details WHERE  pa_id=@PatientId AND pa_flag_id=@PatientFlagDetailId
	DELETE FROM ehr.PatientSmokingStatusDetail WHERE PatientId=@PatientId AND Pa_Flag_Id=@PatientFlagDetailId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
