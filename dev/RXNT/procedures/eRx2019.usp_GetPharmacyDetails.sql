SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_GetPharmacyDetails] 
@PharmacyId BIGINT
AS
BEGIN 
	SELECT p.pharm_id PharmacyId 
	,p.pharm_company_name Name
	,p.ncpdp_numb NCPDPID
	,p.NPI NPI
	,p.pharm_phone Phone
	,p.SS_VERSION PharmacySSVersion
	FROM pharmacies p WITH(NOLOCK)
	WHERE p.pharm_id = @PharmacyId 
                 
                                   
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
