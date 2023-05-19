SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author: Rasheed
-- Create date: 27-Jan-2016
-- Description: To search the allergies
-- Modified By: JahabarYusuff M
-- Modified Date: 05-Dec-2022
-- Description: Retrive allergy rxnormcode
-- =============================================
CREATE PROCEDURE [enc].[usp_SearchAllergies]
@Name VARCHAR(50)= NULL,
@MaxRows INT = 50
AS

BEGIN
SET NOCOUNT ON;
SET @Name = ISNULL(@Name,'')

    SELECT DISTINCT TOP (10) RDAM.DAM_CONCEPT_ID,RDAM.DAM_CONCEPT_ID_TYP, RDAM.DAM_CONCEPT_ID_DESC ,TYP.allergy_type_desc,
REVDL0.EVD_FDB_VOCAB_TYPE_ID,REVDL0.EVD_EXT_VOCAB_TYPE_ID,REVDL0.EVD_EXT_VOCAB_ID
    FROM RDAMAPM0 RDAM WITH(NOLOCK)
LEFT OUTER JOIN patient_allergy_type TYP  WITH(NOLOCK) ON RDAM.DAM_CONCEPT_ID_TYP=TYP.allergy_type
LEFT OUTER JOIN REVDEL0 REVDL0  WITH(NOLOCK) ON REVDL0.evd_fdb_vocab_id=RDAM.DAM_CONCEPT_ID AND REVDL0.EVD_EXT_VOCAB_TYPE_ID IN( 500,512)
     WHERE DAM_CONCEPT_ID_DESC LIKE '%'+@Name+'%'
    ORDER BY DAM_CONCEPT_ID_DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
