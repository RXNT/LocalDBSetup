SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE View [dbo].[vwDocCompIDEnableDisable]
as
SELECT doc_groups.dc_id, doctors.dr_enabled,
max(doctors.dr_create_date)dr_create_date
FROM doc_groups 
INNER JOIN doctors ON doc_groups.dg_id = doctors.dg_id inner join doc_companies
on doc_groups.dc_id = doc_companies.dc_id
 where dr_enabled=0
and doc_groups.dc_id not in (SELECT doc_groups.dc_id
FROM doc_groups INNER JOIN doctors ON doc_groups.dg_id = doctors.dg_id where dr_enabled=1)
and doc_companies.admin_company_id=1 
group by doc_groups.dc_id, doctors.dr_enabled
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
