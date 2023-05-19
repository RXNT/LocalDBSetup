SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 26-Jan-2016
-- Description:	To search the medications
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE   PROCEDURE [enc].[usp_SearchMedications]
	@Name VARCHAR(50),
	@MaxRows INT = 50,
	@DoctorCompanyId INT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT TOP (@MaxRows) medid, med_medid_desc, fdb_rxnorm_map.EVD_EXT_VOCAB_ID as rxnorm_code 
	FROM rnmmidndc fdb_drugs
	LEFT JOIN dbo.Cust_REVDEL0 fdb_rxnorm_map on CAST(fdb_drugs.MEDID AS VARCHAR(20)) = fdb_rxnorm_map.EVD_FDB_VOCAB_ID
	WHERE med_medid_desc like '%'+@Name +'%' AND MEDID BETWEEN 0 AND 999999 
	UNION
	SELECT distinct medid, med_medid_desc, fdb_rxnorm_map.EVD_EXT_VOCAB_ID as rxnorm_code 
	FROM rnmmidndc fdb_drugs 
	LEFT JOIN dbo.Cust_REVDEL0 fdb_rxnorm_map on CAST(fdb_drugs.MEDID AS VARCHAR(20)) = fdb_rxnorm_map.EVD_FDB_VOCAB_ID
	INNER JOIN doc_group_freetext_meds F ON F.drug_id=fdb_drugs.MEDID
	INNER JOIN DOC_GROUPS D ON D.dg_id=F.dg_id 
	WHERE MED_MEDID_DESC LIKE '%'+@Name +'%' 
	AND D.dc_id= @DoctorCompanyId
	ORDER BY MED_MEDID_DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
