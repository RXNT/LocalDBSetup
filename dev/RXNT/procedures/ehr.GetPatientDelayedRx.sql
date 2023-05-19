SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Niyaz
Create date			: 10th-Sep-2018
Description			: 
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [ehr].[GetPatientDelayedRx]
	@PatientId	INT
AS 
BEGIN 	
	SELECT * FROM vwDrDelayedPrescriptionsLog WITH(NOLOCK) WHERE pa_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
