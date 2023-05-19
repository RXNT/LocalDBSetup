SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Update Patient Signature
-- =============================================

CREATE PROCEDURE  [dbo].[usp_UpdatePatientSignature]
@Signature VARCHAR(500),
@Username VARCHAR(100)
AS
BEGIN
	UPDATE dbo.patient_login SET signature=@Signature where pa_username=@Username
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
