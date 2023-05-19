SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 11-NOV-2022
-- Description:	To update QDM data import status flag
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMDataImportStatus]
	@RequestId BIGINT  
AS
BEGIN
	UPDATE [cqm2022].[DoctorCQMCalculationRequest]
	SET DataImportStatus = 1
	WHERE RequestId = @RequestId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
