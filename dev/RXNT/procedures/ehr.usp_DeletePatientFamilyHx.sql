SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 15-Jul-2016
-- Description:	Delete patient Family Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatientFamilyHx]
	@FamilyHxId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	DELETE FROM patient_family_hx 
	WHERE pat_id=@PatientId AND fhxid=@FamilyHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
