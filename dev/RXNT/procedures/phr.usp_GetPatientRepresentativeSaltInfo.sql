SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	28-November-2017
Description			:	Get patient representative password salt.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/
CREATE PROCEDURE  [phr].[usp_GetPatientRepresentativeSaltInfo]
 	@PatientRepresentativeId BIGINT
AS

BEGIN
	SELECT PRI.Text3 AS 'PasswordSALT'
	FROM [phr].[PatientRepresentativesInfo] PRI	
	WHERE PRI.PatientRepresentativeId = @PatientRepresentativeId
		 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
