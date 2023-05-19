SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SyncExistingSurescriptsPharmacies] 
AS
BEGIN
    SET NOCOUNT ON
    UPDATE dbo.pharmacies set pharm_company_name=B.pharm_company_name,
    NPI=B.npi,
	pharm_dea_numb=B.pharm_dea_numb,pharm_address1=B.pharm_address1,pharm_address2=B.pharm_address2,
	pharm_state=B.pharm_state,pharm_city=B.pharm_city,ss_version=B.ss_version,pharm_zip=B.pharm_zip,
	service_level = B.service_level, pharm_fax=B.pharm_fax,pharm_phone=B.pharm_phone, 
    pharm_participant=(Case when A.pharm_participant=1 THEN 262144 ELSE  A.pharm_participant END)
    ,pharm_enabled=B.pharm_enabled FROM  dbo.pharmacies A WITH(NOLOCK) 
    INNER JOIN  RxNTReportUtils..pharmaciesSurescript B WITH(NOLOCK)
    on A.ncpdp_numb=B.ncpdp_numb WHERE Len(B.ncpdp_numb) > 2 and Len(A.ncpdp_numb) > 2 AND a.pharm_enabled=1  AND A.pharm_participant <> 65536 AND A.pharm_participant <> 2 AND B.organization_type='Pharmacy'
    
    
    UPDATE Formularies..pbms set [pbm_name]=B.pharm_company_name,
    [pbm_notes]=B.pharm_company_name,
    [disp_string]=B.pharm_company_name,
	service_level = B.service_level FROM Formularies..pbms A WITH(NOLOCK) 
    INNER JOIN  RxNTReportUtils..pharmaciesSurescript B WITH(NOLOCK)
    on A.rxhub_part_id=B.rxhub_part_id WHERE   B.organization_type='Payer' AND Len(B.rxhub_part_id) > 2 and Len(A.rxhub_part_id) > 2 AND B.pharm_enabled=1  
                   
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
