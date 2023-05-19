SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Get Patient Username
-- =============================================

CREATE PROCEDURE  [dbo].[GetPatientUsername]

AS
BEGIN
	select pa_id,pa_username from dbo.patient_login where signature = 0;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
