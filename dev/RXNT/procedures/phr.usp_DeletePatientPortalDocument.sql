SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	VInod
Create date			:	14-Dec-2017
Description			:	Delete patient Portal Document record.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [phr].[usp_DeletePatientPortalDocument]	    
	@PatientPortalDocumentId    BIGINT,   
    @PatientId		            BIGINT
   
AS

BEGIN
	
UPDATE [phr].[PatientPortalDocuments] SET Active = 0 where PatientPortalDocumentId = @PatientPortalDocumentId
	 and 	PatientId = @PatientId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
