SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.vwPrescPharmActions
AS
SELECT     dbo.prescription_pharm_actions.presc_action_id, dbo.prescription_pharm_actions.pharm_id, dbo.prescription_pharm_actions.pharm_user_id, 
                      dbo.prescription_pharm_actions.action_date, dbo.prescription_pharm_actions.action_val, dbo.prescription_pharm_actions.pres_id, 
                      dbo.pharmacies.pharm_company_name, dbo.pharmacies.pharm_store_numb, dbo.pharmacies.pharm_lic_numb, dbo.pharmacies.pharm_dea_numb, 
                      dbo.pharmacy_users.pharm_user_firstname, dbo.pharmacy_users.pharm_user_lastname, dbo.pharmacy_users.pharm_user_time_difference, 
                      dbo.prescription_pharm_actions.detail_text
FROM         dbo.prescription_pharm_actions INNER JOIN
                      dbo.pharmacy_users ON dbo.prescription_pharm_actions.pharm_user_id = dbo.pharmacy_users.pharm_user_id INNER JOIN
                      dbo.pharmacies ON dbo.prescription_pharm_actions.pharm_id = dbo.pharmacies.pharm_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
