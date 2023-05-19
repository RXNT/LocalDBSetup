SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	28-November-2017
Description			:	Get all patient representatives record.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [phr].[usp_GetAllPatientRepresentatives]
(
    @PatientId BIGINT
)
AS
BEGIN
	SELECT	PR.PatientRepresentativeId, 
			PR.PatientId, 
			PR.PersonRelationshipId,
			PR.FirstName,
            PR.MiddleInitial,
            PR.LastName,
            PR.Sex,
            PR.DOB,
            PR.MaritalStatusId,
            PR.HomePhone,
            PR.CellPhone,
            PR.WorkPhone,
            PR.OtherPhone,
            PR.PhonePreferenceTypeId,
            PR.Email,
            PR.Fax,
            PR.Address1,
            PR.Address2,
            PR.CityId,
            PR.StateId,
            PR.ZipCode,
            PR.ZipExtension,
            PR.PasswordExpiryDate,
            PR.Active,
            PR.CreatedDate,
            PR.CreatedBy,
            PR.ModifiedDate,
            PR.ModifiedBy,
            PR.InactivatedDate,
            PR.InactivatedBy,
            PR.Concurrency,
            PRI.patientRepresentativesInfoId,
            PRI.Text1,
            PRP.Code,
            PRP.Name,
            PRP.Description,
			PPT.Code 'PPT.Code',
			PPT.Name 'PPT.Name',
			PPT.Description 'PPT.Description'
	FROM	[phr].[PatientRepresentatives] PR WITH (NOLOCK)
    INNER JOIN [phr].[PatientRepresentativesInfo] PRI  WITH (NOLOCK) ON PR.PatientRepresentativeId = PRI.PatientRepresentativeId
    LEFT JOIN [phr].[PersonRelationships] PRP WITH (NOLOCK) ON PR.PersonRelationshipId = PRP.PersonRelationshipId
	LEFT JOIN [phr].[PhonePreferenceTypes] PPT WITH (NOLOCK) ON PR.PhonePreferenceTypeId = PPT.PhonePreferenceTypeId
    WHERE PR.PatientId = @PatientId AND PR.Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
