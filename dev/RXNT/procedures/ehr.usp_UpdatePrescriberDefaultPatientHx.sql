SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 20-June-2016
-- Description:	To get prescription date info
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpdatePrescriberDefaultPatientHx]
	@DoctorId BIGINT,
	@LookUpPeriod INT
AS
BEGIN
 UPDATE DOCTORS 
	SET dr_def_pat_history_back_to = @LookUpPeriod
 WHERE DR_ID = @DoctorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
