SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 03/02/2020
-- Description: Fetch all drugs by ndc list
-- Modified By : Mukhil Padmanabhan
-- Modified Date: 11-May-2021
-- Modified Description: Added IsDrugActive flag
-- =============================================  
CREATE  PROCEDURE [eRx2019].[usp_SearchDrugsByNDCList]
@NDCArray AS XML
 
AS  

  BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT A.MEDID DrugId, MED_MEDID_DESC DrugName, A.NDC,ISNULL(AD.IS_ACTIVE,0) IsDrugActive -- CASE WHEN R1.OBSDTEC  IS NULL THEN 1 ELSE 0 END IsDrugActive 
	FROM RMINDC1 A with(nolock) 
	INNER JOIN RMIID1 B with(nolock) ON A.MEDID=B.MEDID 
	INNER join RNDC14 R1 with(nolock) on A.ndc=R1.ndc 
	LEFT OUTER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON A.MEDID = AD.MEDID
	INNER JOIN @NDCArray.nodes('/ArrayOfString/string') AS x ( y ) ON x.y.value('.','VARCHAR(50)')=A.NDC 
	WHERE A.MEDID<1000000
	--WHERE A.NDC IN (" + strNdcList + "
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
