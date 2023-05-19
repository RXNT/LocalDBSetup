SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	28-November-2017
Description			:	Validate representative login by username.
Last Modified By	:	Ayja Weems
Last Modifed Date	:	23-Jun-2022
Last Modification   :   Return accepted_terms_date
=======================================================================================
*/

CREATE PROCEDURE  [phr].[usp_ValidateRepresentativeLogin]
    @UserName	VARCHAR(MAX)
AS
BEGIN
	SELECT PR.PatientRepresentativeId, 
		PR.PatientId, 
		PRI.Text1, 
		PRI.Text2, 
		PRI.Text3, 
		PR.FirstName, 
		PR.LastName, 
		PR.MiddleInitial,
		PR.PersonRelationshipId,
		REL.Name as 'PersonRelationshipName',
		PR.accepted_terms_date
    FROM phr.PatientRepresentativesInfo PRI WITH(NOLOCK)
    INNER JOIN phr.PatientRepresentatives PR WITH(NOLOCK) ON PR.PatientRepresentativeId = PRI.PatientRepresentativeId
	INNER JOIN phr.PersonRelationships REL WITH(NOLOCK) ON REL.PersonRelationshipId = PR.PersonRelationshipId
    WHERE PRI.Text1 = @UserName AND
        PRI.Active = 1 AND
        PR.PasswordExpiryDate >= GETDATE()
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
