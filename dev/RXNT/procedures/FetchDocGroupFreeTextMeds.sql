SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchDocGroupFreeTextMeds]
@dg_id BIGINT ,
@filter VARCHAR(200)=NULL,
@max_records int = 0
AS
BEGIN
	IF @max_records>0
	BEGIN
		SELECT top(@max_records) a.dgfm_id,a.drug_id,a.drug_name,a.drug_category, a.preferred_name, b.MED_REF_DEA_CD 
		FROM doc_group_freetext_meds a INNER JOIN RNMMIDNDC b ON a.drug_id=b.MEDID 
		WHERE a.dg_id=@dg_id AND (@filter IS NULL OR a.drug_name LIKE  @filter+'%') AND a.is_active=1 
		ORDER BY a.drug_name 
	END
	ELSE
	BEGIN
		SELECT a.dgfm_id,a.drug_id,a.drug_name,a.drug_category,a.preferred_name,b.MED_REF_DEA_CD 
		FROM doc_group_freetext_meds a INNER JOIN RNMMIDNDC b ON a.drug_id=b.MEDID 
		WHERE a.dg_id=@dg_id AND (@filter IS NULL OR a.drug_name LIKE  @filter+'%') AND a.is_active=1 
		ORDER BY a.drug_name 
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
