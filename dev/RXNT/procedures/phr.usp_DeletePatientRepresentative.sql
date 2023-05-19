SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	28-November-2017
Description			:	Delete patient representative record.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [phr].[usp_DeletePatientRepresentative]	    
	@PatientRepresentativeId    BIGINT, 
    @InactivatedBy              BIGINT
AS

BEGIN

    UPDATE PatientRepresentatives
    SET 
        Active          = 0,
        InactivatedBy   = @InactivatedBy,
        InactivatedDate = GETDATE()
    WHERE PatientRepresentativeId = @PatientRepresentativeId

    UPDATE PatientRepresentativesInfo
    SET 
        Active          = 0,
        InactivatedBy   = @InactivatedBy,
        InactivatedDate = GETDATE()
    WHERE PatientRepresentativeId = @PatientRepresentativeId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
