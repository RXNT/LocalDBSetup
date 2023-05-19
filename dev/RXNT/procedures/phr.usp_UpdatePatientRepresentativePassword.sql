SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	28-November-2017
Description			:	Update patient representative password.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [phr].[usp_UpdatePatientRepresentativePassword]	    
	@PatientRepresentativesInfoId       BIGINT,   
    @Password                           VARCHAR(500),
    @ModifiedBy                         BIGINT,
	@PatientRepresentativeId			BIGINT
AS

BEGIN

    UPDATE PatientRepresentativesInfo
    SET 
        Text2           = @Password,
        ModifiedDate    = GETDATE(),
        ModifiedBy      = @ModifiedBy 
    WHERE PatientRepresentativesInfoId = @PatientRepresentativesInfoId

	UPDATE PatientRepresentatives
    SET 
        PasswordExpiryDate		= DATEADD(year, 3, GETDATE()),
        ModifiedDate			= GETDATE(),
        ModifiedBy				= @ModifiedBy 
    WHERE PatientRepresentativeId = @PatientRepresentativeId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
