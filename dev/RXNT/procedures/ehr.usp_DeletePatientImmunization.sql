SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 5-Aug-2016
-- Description:	To Delete patient immunization
-- Modified By: JahabarYusuff
-- Description:	To Delete patient immunization logically
-- Modified Date: 10-Aug-2017
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatientImmunization]
 @VaccineRecordId INT,
 @LoggedInUserId BIGINT
AS
BEGIN
	UPDATE tblVaccinationRecord SET active=0, last_modified_date=GETDATE(), last_modified_by=@LoggedInUserId,action_code='D' WHERE [vac_rec_id] = @VaccineRecordId   
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
