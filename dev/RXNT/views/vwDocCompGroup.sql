SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwDocCompGroup]
AS
SELECT doc_companies.dc_name, doc_companies.admin_company_id, doc_groups.dg_name, doc_companies.dc_id, doc_groups.dg_id
FROM doc_companies 
INNER JOIN doc_groups ON doc_companies.dc_id = doc_groups.dc_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
