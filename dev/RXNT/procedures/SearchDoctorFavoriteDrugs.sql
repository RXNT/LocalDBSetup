SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: April 12, 2018
-- Description:	Search No coverage based Doctor Favorite Drugs
-- =============================================
CREATE PROCEDURE [dbo].[SearchDoctorFavoriteDrugs]
(
	-- Add the parameters for the stored procedure here,
	@DoctorGroupId		BIGINT,
	@DoctorId			BIGINT,
	@DrugName VARCHAR(200)=NULL
)
AS
BEGIN
	SELECT DISTINCT MED_NAME_ID, MED_REF_GEN_DRUG_NAME_CD DRUGTYPE, MED_REF_FED_LEGEND_IND rxtype, A.MEDID, A.MED_MEDID_DESC, -1 status,
	A.MED_REF_DEA_CD drug_class, ETC_ID, ETC_NAME 
	FROM RNMMIDNDC A WITH(NOLOCK)
	INNER JOIN doc_fav_drugs C WITH(NOLOCK) ON A.MEDID = C.drug_id 
	INNER JOIN RMIID1 D WITH(NOLOCK) ON A.MEDID = D.MEDID 
	WHERE dr_id = @DoctorId
	AND OBSDTEC IS NULL
	AND   (@DrugName IS NULL OR A.MED_MEDID_DESC LIKE @DrugName+'%')  
	UNION
	SELECT DISTINCT MED_NAME_ID, MED_REF_GEN_DRUG_NAME_CD DRUGTYPE, MED_REF_FED_LEGEND_IND rxtype, A.MEDID, A.MED_MEDID_DESC, -1 status,
	A.MED_REF_DEA_CD drug_class, ETC_ID, ETC_NAME 
	FROM RNMMIDNDC A WITH(NOLOCK)
	INNER JOIN doc_group_fav_drugs B WITH(NOLOCK) ON A.MEDID=B.drug_id
	INNER JOIN RMIID1 D WITH(NOLOCK) ON A.MEDID = D.MEDID
	WHERE dg_id=@DoctorGroupId AND OBSDTEC IS NULL AND   (@DrugName IS NULL OR A.MED_MEDID_DESC LIKE  @DrugName+'%')  
	ORDER BY A.MED_MEDID_DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
