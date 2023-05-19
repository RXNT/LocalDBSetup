SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.vwDocRights
AS

SELECT     rights.right_val, doc_rights.dr_id 
FROM         rights INNER JOIN
                      doc_rights ON rights.right_id = doc_rights.right_id
UNION 
SELECT     rights.right_val, doc_security_group_members.dr_id 
FROM         rights INNER JOIN doc_security_group_rights ON rights.right_id = doc_security_group_rights.right_id 
INNER JOIN   doc_security_group_members ON doc_security_group_rights.dsg_id = doc_security_group_members.dsg_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
