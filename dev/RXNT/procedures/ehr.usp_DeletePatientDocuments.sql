SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	05-JULY-2016
Description			:	This procedure is used to Delete Patient Documents
Last Modified By	:	Ayja Weems
Last Modifed Date	:	23-Feb-2021
Last Modification	:	Remove the row from PatientPortalDocuments too if it exists.
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_DeletePatientDocuments]	
	 @DOCUMENTID			BIGINT	
AS
BEGIN
	delete from phr.PatientPortalDocuments where DocumentId = @DOCUMENTID
	delete from patient_documents where document_id = @DOCUMENTID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
