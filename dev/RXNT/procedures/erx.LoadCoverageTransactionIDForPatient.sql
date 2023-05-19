SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To get the patient Coverage Transaction Id
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadCoverageTransactionIDForPatient]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT top 1 transaction_message_id FROM patients_coverage_info WHERE pa_id=@PatientId    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
