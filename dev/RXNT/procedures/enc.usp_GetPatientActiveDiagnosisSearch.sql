SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 15-Jan-2019
-- Description:	Search Patient Active Diag (Referred LAB API)
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPatientActiveDiagnosisSearch] 
	@PATIENT_ID BIGINT,
	@Name Varchar(MAX) 
	
	
AS
BEGIN
	 SELECT icd9, icd9_description,icd9_desc,icd10,icd10_desc 
	 FROM patient_active_diagnosis WITH(NOLOCK) WHERE 
	 pa_id=@PATIENT_ID And (icd9_description LIKE @Name+'%' OR icd9 LIKE @Name+'%'
	  OR icd10 LIKE @Name+'%') ORDER BY icd9_description 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
