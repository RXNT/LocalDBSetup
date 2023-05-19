SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_DeleteAllSurescriptsPharmacies] 
AS
BEGIN
    SET NOCOUNT ON
    TRUNCATE TABLE RxNTReportUtils.dbo.pharmaciesSureScript
		
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
