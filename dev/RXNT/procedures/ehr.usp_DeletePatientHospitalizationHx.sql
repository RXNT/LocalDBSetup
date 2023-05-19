SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		VINOD
-- Create date: 2-Feb-2018
-- Description:	Delete Hospitalization Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatientHospitalizationHx]
	@HospitalizationHxId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	UPDATE patient_hospitalization_hx SET enable=0
	WHERE pat_id=@PatientId AND hosphxid=@HospitalizationHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
