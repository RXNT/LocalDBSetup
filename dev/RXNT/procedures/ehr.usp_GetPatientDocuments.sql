SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	05-JULY-2016
Description			:	This procedure is used to Get Patient Documents
Last Modified By	:	Samip Neupane
Last Modifed Date	:	12/29/2022
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetPatientDocuments]	
	 @DOCUMENTID			BIGINT	
AS
BEGIN
	 SELECT DOCUMENT_ID, PAT_ID, SRC_DR_ID, UPLOAD_DATE, A.TITLE DOC_TITLE, DESCRIPTION, FILENAME,Comment, DOCUMENT_DATE,
     A.CAT_ID, B.TITLE CAT_TITLE, A.OWNER_ID, A.OWNER_TYPE, A.ENC_ID FROM PATIENT_DOCUMENTS A INNER JOIN PATIENT_DOCUMENTS_CATEGORY B 
     ON A.CAT_ID = B.CAT_ID WHERE A.DOCUMENT_ID = @DOCUMENTID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
