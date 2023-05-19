SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 8-Aug-2016
-- Description:	To delete vaccine Types
-- Mod1ified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeleteVaccineType]
  @RecordId INT
AS
BEGIN
	UPDATE tblVaccineTypes
	SET active = 0
	WHERE record_id = @RecordId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
