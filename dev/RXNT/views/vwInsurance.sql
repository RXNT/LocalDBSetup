SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.vwInsurance
AS
SELECT dbo.ins_carriers.ic_name, dbo.ins_formularies.ddid, 
    dbo.ins_formulary_codes.ifc_code, 
    dbo.ins_formulary_codes.ifc_desc
FROM dbo.ins_carriers INNER JOIN
    dbo.ins_formularies ON 
    dbo.ins_carriers.ic_id = dbo.ins_formularies.ic_id INNER JOIN
    dbo.ins_formulary_code_links ON 
    dbo.ins_formularies.if_id = dbo.ins_formulary_code_links.if_id INNER
     JOIN
    dbo.ins_formulary_codes ON 
    dbo.ins_formulary_code_links.ifc_id = dbo.ins_formulary_codes.ifc_id
GO
SET ANSI_NULLS OFF 
GO

GO
