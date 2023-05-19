SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author: Rama krishna
-- Create date: JAN 24, 2017
-- Description: Load Doctor Group Favorite Drugs
-- Modified By: Vijay D
-- Modified Date: 21st SEP 2017
-- =============================================
CREATE PROCEDURE [dbo].[LoadDoctorGroupFavoriteDrugsWithGCN]

@FormularyTableName VARCHAR(50),
@MaxRecords int,
@DoctorGroupId bigint,
@FavDrugs VARCHAR(50)
As
BEGIN
DECLARE @Query VARCHAR(MAX)
SET @FavDrugs = rtrim(ltrim(@FavDrugs))
IF @MaxRecords = -1
BEGIN
SET @Query = 'SELECT ';
END
ELSE
BEGIN
SET @Query = 'SELECT TOP ('+CAST(@MaxRecords AS VARCHAR(10))+')';
END

SET @Query = @Query + 'R.MEDID,R.MED_MEDID_DESC,
max(dgfv.dgfd_id) dgfd_id,
max(dgfv.dg_id) dg_id, MAX(CASE WHEN FRM.form_status IS null THEN -1 ELSE FRM.form_status END) status,
RN.ETC_ID, MIN(R.MED_REF_GEN_DRUG_NAME_CD) drugtype,
RN.ETC_NAME,RN.MED_REF_DEA_CD drug_class
FROM RMIID1 R WITH(NOLOCK)
INNER JOIN doc_group_fav_drugs  dgfv ON dgfv.drug_id =  R.MEDID
INNER JOIN RNMMIDNDC RN on RN.MEDID = R.MEDID
LEFT OUTER JOIN '+@FormularyTableName+' FRM WITH(NOLOCK) on R.GCN_STRING = FRM.GCN
WHERE dgfv.dg_id='+CAST(@DoctorGroupId AS VARCHAR(50))+' AND R.MED_MEDID_DESC like  ''%'+ @FavDrugs +'%''  
group by R.MEDID,R.MED_MEDID_DESC,RN.MED_REF_DEA_CD,ETC_ID,ETC_NAME
ORDER BY R.MED_MEDID_DESC '
 
EXEC (@Query)

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
