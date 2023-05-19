SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 31-JAN-2017
-- Description:	To Get Last Rx Date
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_GetPatientLastRxDateForMed]
  @PatientId BIGINT,
  @DrugId BIGINT  
AS
BEGIN
	SELECT MAX(pres_approved_date) as pres_approved_date FROM prescriptions pres WITH(NOLOCK) 
	INNER JOIN prescription_details pd WITH(NOLOCK) ON pres.pres_id=pd.pres_id 
	WHERE pa_id=@PatientId AND pd.ddid=@DrugId AND pres.pres_void=0
END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
