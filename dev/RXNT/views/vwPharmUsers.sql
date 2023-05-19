SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.vwPharmUsers
AS
SELECT     dbo.pharmacy_users.pharm_user_id, dbo.pharmacy_users.pharm_user_prefix, dbo.pharmacy_users.pharm_user_firstname, 
                      dbo.pharmacy_users.pharm_user_mid_initial, dbo.pharmacy_users.pharm_user_lastname, dbo.pharmacy_users.pharm_user_suffix, 
                      dbo.pharmacy_users.pharm_user_username, dbo.pharmacy_users.pharm_user_password, dbo.pharmacy_users.pharm_user_is_primary, 
                      dbo.pharmacies.pharm_id, dbo.pharmacies.pharm_company_name, dbo.pharmacies.pharm_store_numb, dbo.pharmacies.pharm_lic_numb, 
                      dbo.pharmacies.pharm_dea_numb, dbo.pharmacies.pharm_address1, dbo.pharmacies.pharm_address2, dbo.pharmacies.pharm_city, 
                      dbo.pharmacies.pharm_state, dbo.pharmacies.pharm_zip, dbo.pharmacies.pharm_phone, dbo.pharmacies.pharm_phone_reception, 
                      dbo.pharmacies.pharm_fax, dbo.pharmacies.pharm_email, dbo.pharmacies.pharm_notify_fax, dbo.pharmacies.pharm_notify_email, 
                      dbo.pharmacies.pharm_enabled, dbo.pharmacies.pharm_create_date, dbo.pharmacies.pharm_participant, dbo.pharmacies.ncpdp_numb, 
                      dbo.pharmacies.disp_type, dbo.pharmacies.enable_dummy_code, dbo.pharmacies.sfi_is_sfi, dbo.pharmacies.sfi_pharmid, 
                      dbo.pharmacy_users.pharm_user_agreement_acptd, dbo.pharmacy_users.pharm_user_time_difference, 
                      dbo.pharmacy_users.pharm_user_hipaa_agreement_acptd
FROM         dbo.pharmacy_users INNER JOIN
                      dbo.pharmacies ON dbo.pharmacy_users.pharm_id = dbo.pharmacies.pharm_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
