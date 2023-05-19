SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description:	Get Patient Salt Info
-- =============================================
CREATE PROCEDURE  [dbo].[usp_GetPatientSaltInfo]
 	@PatientId			BIGINT
AS
BEGIN
	SELECT PL.salt AS 'PasswordSALT'
	FROM [dbo].[patient_login] PL	
	WHERE PL.pa_id		= @PatientId
		 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
