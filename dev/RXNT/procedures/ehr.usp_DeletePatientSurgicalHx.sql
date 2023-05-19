SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 20-Jul-2016
-- Description:	Delete Surgical Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatientSurgicalHx]
	@SurgicalHxId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	DELETE FROM patient_surgery_hx 
	WHERE pat_id=@PatientId AND surghxid=@SurgicalHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
