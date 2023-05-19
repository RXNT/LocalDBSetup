SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 29-Jun-2016
-- Description:	To search the medications
-- Modified By: Samip Neupane(ED-7385)
-- Modified Date: 12/02/2022
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchMedications]
	@Name VARCHAR(50) = NULL,
	@MaxRows INT = 50,
	@DoctorGroupId INT,
	@DoctorCompanyId INT
AS

BEGIN
	SET @Name = ISNULL(@Name,'')
	SET NOCOUNT ON;
	
	SELECT distinct TOP (@MaxRows) medid, med_medid_desc, fdb_rxnorm_map.EVD_EXT_VOCAB_ID as rxnorm_code
	FROM rnmmidndc fdb_drugs WITH(NOLOCK)
    LEFT JOIN dbo.Cust_REVDEL0 fdb_rxnorm_map WITH(NOLOCK) on CAST(fdb_drugs.MEDID AS VARCHAR(20)) = fdb_rxnorm_map.EVD_FDB_VOCAB_ID
	WHERE med_medid_desc like '%'+@Name +'%' AND MEDID BETWEEN 0 AND 999999 
	UNION
	SELECT distinct medid, med_medid_desc, fdb_rxnorm_map.EVD_EXT_VOCAB_ID as rxnorm_code
	FROM rnmmidndc fdb_drugs WITH(NOLOCK)
    LEFT JOIN dbo.Cust_REVDEL0 fdb_rxnorm_map WITH(NOLOCK) on CAST(fdb_drugs.MEDID AS VARCHAR(20)) = fdb_rxnorm_map.EVD_FDB_VOCAB_ID
	INNER JOIN doc_group_freetext_meds F ON F.drug_id = fdb_drugs.MEDID
	INNER JOIN DOC_GROUPS D ON D.dg_id=F.dg_id 
	WHERE MED_MEDID_DESC LIKE '%'+@Name +'%' 
	AND D.dc_id= @DoctorCompanyId
	AND is_active=1
	ORDER BY MED_MEDID_DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
