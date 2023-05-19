SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rama krishna
-- Create date: JAN 25, 2017
-- Description:	Load Doctor Group Alternative Favorite Drugs
-- =============================================
CREATE PROCEDURE [dbo].[LoadDoctorGroupAlternativeFavoriteDrugsWithGCN]--'Formularies..RxHub_VITAS_ALT_VXALT',63102,1001839

	@FormularyTableName VARCHAR(50),	
	@DoctorGroupId		BIGINT,
	@DrugId				BIGINT
As
BEGIN
	DECLARE @Query VARCHAR(MAX)
	DECLARE @SorceGCN VARCHAR(50)
	
	select top 1 @SorceGCN = R.gcn_string from RMIID1 R WITH(NOLOCK)
	where R.MEDID = @DrugId  

	SET @Query =  '
	SELECT  R.MEDID,R.MED_MEDID_DESC,
	max(dgfv.dgfd_id) dgfd_id, 
	max(dgfv.dg_id) dg_id, MAX(CASE WHEN FRM.form_status IS null THEN 0 ELSE FRM.form_status END) form_status, 
	RN.ETC_ID, MIN(R.MED_REF_GEN_DRUG_NAME_CD) drug_type,
	RN.ETC_NAME,RN.MED_REF_DEA_CD drug_class
				  FROM RMIID1 R WITH(NOLOCK)
				  INNER JOIN doc_group_fav_drugs  dgfv WITH(NOLOCK) ON dgfv.drug_id =  R.MEDID
				  INNER JOIN RNMMIDNDC RN WITH(NOLOCK) on RN.MEDID = R.MEDID  
			   	  INNER JOIN '+@FormularyTableName+' FRM WITH(NOLOCK) on R.GCN_STRING = FRM.alt_gcn 
				  WHERE dgfv.dg_id='+CAST(@DoctorGroupId AS VARCHAR(50))+' 
				  AND FRM.source_gcn = '''+@SorceGCN+'''
				  group by R.MEDID,R.MED_MEDID_DESC,RN.MED_REF_DEA_CD,ETC_ID,ETC_NAME  
				  ORDER BY R.MED_MEDID_DESC'      
				  PRINT @Query    
    EXEC (@Query)
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
