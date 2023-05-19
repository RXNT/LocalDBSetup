SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 22-Feb-2018
-- Description:	Delete patient Family Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [phr].[usp_DeletePatientFamilyHx]
	@FamilyHxId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	UPDATE patient_family_hx_external
	SET pfhe_enable = 0 
	
	WHERE pfhe_pat_id=@PatientId AND pfhe_fhxid=@FamilyHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
