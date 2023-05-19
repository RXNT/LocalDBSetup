SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwAdminPharmacies]
AS
SELECT     dbo.pharmacies.pharm_company_name, dbo.pharmacies.pharm_store_numb, dbo.pharmacies.pharm_participant,dbo.pharmacies.pharm_lic_numb, dbo.pharmacies.pharm_dea_numb, 
                      dbo.pharmacies.pharm_address1, dbo.pharmacies.pharm_address2, dbo.pharmacies.pharm_city, dbo.pharmacies.pharm_state, 
                      dbo.pharmacies.pharm_zip, dbo.pharmacies.pharm_phone, dbo.pharmacies.pharm_fax, dbo.pharmacies.pharm_pending_addition, dbo.doctors.dr_id, 
                      dbo.doctors.dr_first_name, dbo.doctors.dr_last_name, dbo.pharmacies.pharm_create_date, dbo.pharmacies.pharm_enabled, 
                      dbo.pharmacies.pharm_id,dbo.pharmacies.service_level
FROM         dbo.pharmacies WITH(NOLOCK) LEFT OUTER JOIN
                      dbo.doctors WITH(NOLOCK) ON dbo.pharmacies.pharm_added_by_dr_id = dbo.doctors.dr_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
