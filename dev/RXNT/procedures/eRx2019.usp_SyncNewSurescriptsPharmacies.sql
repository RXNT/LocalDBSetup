SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SyncNewSurescriptsPharmacies] 
AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO [dbo].[pharmacies](pharm_company_name,pharm_store_numb,pharm_lic_numb,pharm_dea_numb,NPI,pharm_address1,pharm_address2,pharm_city, pharm_state,pharm_zip,pharm_phone,pharm_phone_reception,pharm_fax,pharm_email,pharm_notify_fax,pharm_notify_email,pharm_enabled,pharm_create_date,pharm_participant,ncpdp_numb,disp_type,enable_dummy_code,sfi_is_sfi,sfi_pharmid,pharm_added_by_dr_id,pharm_pending_addition,ss_version,service_level,pharm_fax_email) 
	SELECT pharm_company_name,pharm_store_numb,pharm_lic_numb,pharm_dea_numb,npi,pharm_address1,pharm_address2,pharm_city, pharm_state,pharm_zip,pharm_phone,pharm_phone_reception,pharm_fax,pharm_email,pharm_notify_fax,pharm_notify_email,pharm_enabled,pharm_create_date,pharm_participant,ncpdp_numb,disp_type,enable_dummy_code,sfi_is_sfi,sfi_pharmid,pharm_added_by_dr_id,pharm_pending_addition,ss_version,service_level,pharm_fax_email
    from RxNTReportUtils..pharmaciesSurescript WITH(NOLOCK) 
    where LEN(ncpdp_numb) > 2AND ncpdp_numb not in (select ncpdp_numb
	from pharmacies WITH(NOLOCK) where pharm_enabled=1 AND LEN(ncpdp_numb) > 2) and pharm_enabled=1  AND organization_type='Pharmacy'
	
	INSERT INTO [Formularies].[dbo].[pbms]
           ([rxhub_part_id]
           ,[pbm_name]
           ,[pbm_notes]
           ,[disp_string]
           ,[disp_options]
           ,[formulary_src]
           ,[pharmacy_id]
           ,[disp_auth]
           ,[is_gcn_based_form]
           ,[is_direct_connect]
           ,service_level
           ,pbm_enabled) 
	SELECT rxhub_part_id,pharm_company_name,pharm_company_name,pharm_company_name,'1|Unknown|#FFFF00|yellowSqr.gif,0|Not Covered|#993399|purpleSqr.gif,1|Off Formulary|#FF0000|redSqr.gif,3|Preferred|#00FF00|greenSqr.gif',1,0,NULL,0,NULL,service_level,pharm_enabled
    from RxNTReportUtils..pharmaciesSurescript WITH(NOLOCK) 
    where LEN(rxhub_part_id) > 2AND rxhub_part_id not in (select rxhub_part_id
	from Formularies..pbms WITH(NOLOCK) where LEN(rxhub_part_id) > 2) and pharm_enabled=1  AND organization_type='Payer'
	
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
