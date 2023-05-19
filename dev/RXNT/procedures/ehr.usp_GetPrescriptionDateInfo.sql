SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 20-June-2016
-- Description:	To get prescription date info
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPrescriptionDateInfo]
	@PrecriptonDetailId BIGINT
AS
BEGIN
	SELECT PDt_Id,
	 dtStartDate, 
	 dtEndDate, 
	 CreatedBy, 
	 CreatedDate, 
	 LastModifiedBy, 
	 LastModifiedDate,
	 Active, 
	 pd_id 
	 FROM Prescription_Date_Info with(nolock)
	 WHERE pd_id = @PrecriptonDetailId AND active=1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
