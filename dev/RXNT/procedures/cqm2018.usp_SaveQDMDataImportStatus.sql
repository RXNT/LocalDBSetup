SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 09-Feb-2018
-- Description:	To update QDM data import status flag
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SaveQDMDataImportStatus]
	@RequestId BIGINT  
AS
BEGIN
	UPDATE [cqm2018].[DoctorCQMCalculationRequest]
	SET DataImportStatus = 1
	WHERE RequestId = @RequestId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
