SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		VINOD
-- Create date: 2-Feb-2018
-- Description:	Delete Surgical Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [phr].[usp_DeletePatientSurgicalHx]
	@SurgicalHxId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	UPDATE patient_surgery_hx_external SET pse_enable=0
	WHERE pse_pat_id=@PatientId AND pse_surghxid=@SurgicalHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
