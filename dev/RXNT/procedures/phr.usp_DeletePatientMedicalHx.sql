SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 2-Feb-2018
-- Description:	Delete  Medical Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [phr].[usp_DeletePatientMedicalHx]
	@MedicalHxId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	UPDATE patient_medical_hx_external SET pme_enable=0
	WHERE pme_pat_id=@PatientId AND pme_medhxid=@MedicalHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
