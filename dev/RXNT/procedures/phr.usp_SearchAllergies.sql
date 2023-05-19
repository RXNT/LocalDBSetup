SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		VINOD
-- Create date: 15-Feb-2018
-- Description:	To search the allergies
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [phr].[usp_SearchAllergies] 
	@Name VARCHAR(50)= NULL,
	@MaxRows INT = 50
AS

BEGIN
	SET NOCOUNT ON;
	SET @Name = ISNULL(@Name,'')
	
    SELECT DISTINCT TOP (@MaxRows) RDAM.DAM_CONCEPT_ID,RDAM.DAM_CONCEPT_ID_TYP, RDAM.DAM_CONCEPT_ID_DESC ,at.allergy_type_desc,
	REVDL0.EVD_FDB_VOCAB_TYPE_ID,REVDL0.EVD_EXT_VOCAB_TYPE_ID,REVDL0.EVD_EXT_VOCAB_ID
    FROM RDAMAPM0 RDAM WITH(NOLOCK)
    LEFT OUTER JOIN patient_allergy_type at  WITH(NOLOCK) ON DAM_CONCEPT_ID_TYP=at.allergy_type
    LEFT OUTER JOIN REVDEL0 REVDL0  WITH(NOLOCK) ON REVDL0.evd_fdb_vocab_id=RDAM.DAM_CONCEPT_ID AND REVDL0.EVD_EXT_VOCAB_TYPE_ID = 500

    WHERE DAM_CONCEPT_ID_DESC LIKE '%'+@Name+'%'
    ORDER BY DAM_CONCEPT_ID_DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
