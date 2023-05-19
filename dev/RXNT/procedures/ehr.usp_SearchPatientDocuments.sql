SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	04-JULY-2016
Description			:	This procedure is used to Search Patient Documents
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SearchPatientDocuments]	
	@PatientId			BIGINT,
	@Title VARCHAR(80),
	@Description VARCHAR(225)	
AS
BEGIN
	 SELECT DOCUMENT_ID, PAT_ID, SRC_DR_ID, UPLOAD_DATE, A.TITLE DOC_TITLE, DESCRIPTION, FILENAME,Comment, DOCUMENT_DATE, 
     A.CAT_ID, B.TITLE CAT_TITLE, A.ENC_ID FROM PATIENT_DOCUMENTS A INNER JOIN PATIENT_DOCUMENTS_CATEGORY B 
     ON A.CAT_ID = B.CAT_ID WHERE A.PAT_ID = @PatientId AND A.title like '%'+@Title+'%' AND A.DESCRIPTION like '%'+@Description+'%' ORDER BY A.UPLOAD_DATE DESC, DOCUMENT_ID DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
