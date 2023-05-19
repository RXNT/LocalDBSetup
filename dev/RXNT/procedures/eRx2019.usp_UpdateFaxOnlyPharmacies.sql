SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_UpdateFaxOnlyPharmacies] 
AS
BEGIN
    SET NOCOUNT ON
    --Change pharmacies not in surescript list to fax only
    UPDATE dbo.pharmacies set pharm_participant=1,service_level=1 where ncpdp_numb not in (select ncpdp_numb from 
	RxNTReportUtils.dbo.pharmaciesSurescript WITH(NOLOCK) where Len(ncpdp_numb) > 2) and (pharm_participant = 262144 or  pharm_participant =262145)        
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
