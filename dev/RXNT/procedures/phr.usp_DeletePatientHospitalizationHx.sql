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
CREATE PROCEDURE [phr].[usp_DeletePatientHospitalizationHx]
	@HospitalizationHxId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	UPDATE patient_hospitalization_hx_external SET phe_enable=0
	WHERE phe_pat_id=@PatientId AND phe_hosphxid=@HospitalizationHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
