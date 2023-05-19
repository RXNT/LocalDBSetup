SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	28-November-2017
Description			:	Create/Update patient representative record.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [phr].[usp_SavePatientRepresentative]	    
	@PatientRepresentativeId    BIGINT,   
    @DoctorCompanyId            BIGINT,
    @PatientId                  BIGINT,
    @PersonRelationshipId       BIGINT          = NULL, 
    @FirstName                  VARCHAR(50), 
    @MiddleInitial              VARCHAR(50)		= NULL, 
    @LastName                   VARCHAR(60), 
    @Sex                        VARCHAR(3), 
    @DOB                        DATETIME,
    @MaritalStatusId            BIGINT          = NULL, 
    @HomePhone                  VARCHAR(20),
    @CellPhone                  VARCHAR(20)		= NULL,                      
    @WorkPhone                  VARCHAR(20)		= NULL, 
    @OtherPhone                 VARCHAR(20)		= NULL, 
    @PhonePreferenceTypeId      BIGINT          = NULL, 
    @Email                      VARCHAR(80),
    @Fax                        VARCHAR(20)		= NULL, 
    @Address1                   VARCHAR(100), 
    @Address2                   VARCHAR(100)    = NULL,
    @CityId                     BIGINT, 
    @StateId                    BIGINT, 
    @ZipCode                    VARCHAR(5), 
    @ZipExtension               VARCHAR(4)		= NULL, 
    @PasswordExpiryDate         DATETIME,
    @Active                     TINYINT,
    @LoggedInUserId             BIGINT          = NULL,
    @Username                   VARCHAR(50)		= NULL, 
    @Password                   VARCHAR(500)    = NULL,
    @Salt                       VARCHAR(500)    = NULL,
    @PatientRepresentativesInfoId BIGINT        = NULL,
    @UserExistsErr		        BIT OUTPUT,
    @ConcurrencyErr             BIT OUTPUT,
    @RepresentativeId           BIGINT OUTPUT,
    @Concurrency                VARCHAR(20)    = NULL
AS
BEGIN

    SET NOCOUNT ON;

	SET @UserExistsErr = 0;
    SET @ConcurrencyErr = 0;
    SET @RepresentativeId = 0;

	IF ISNULL(@PatientRepresentativeId, 0) = 0 

        BEGIN
            --Check user name existance
            IF EXISTS(SELECT 1 FROM [phr].[PatientRepresentativesInfo] WHERE Text1 = @Username)
                BEGIN
                    SET @UserExistsErr = 1
                END
            ELSE 
                BEGIN
                    --Insert representative basic info
                    INSERT INTO PatientRepresentatives(
                        PatientId, PersonRelationshipId, FirstName, MiddleInitial, LastName, Sex, DOB, MaritalStatusId, HomePhone, 
                        CellPhone, WorkPhone, OtherPhone, PhonePreferenceTypeId, Email, Fax, Address1, Address2, CityId,
                        StateId, ZipCode, ZipExtension, PasswordExpiryDate, Active, CreatedDate, CreatedBy
                    ) 
                    VALUES (
                        @PatientId, @PersonRelationshipId, @FirstName, @MiddleInitial, @LastName, @Sex, @DOB, @MaritalStatusId, @HomePhone,
                        @CellPhone, @WorkPhone, @OtherPhone, @PhonePreferenceTypeId,  @Email, @Fax, @Address1, @Address2, @CityId,
                        @StateId, @ZipCode, @ZipExtension, @PasswordExpiryDate, @Active, GETDATE(), @LoggedInUserId
                    )

                    SET @RepresentativeId = SCOPE_IDENTITY();

                    --Insert representative login info
                    INSERT INTO PatientRepresentativesInfo(
                        PatientRepresentativeId, Text1, Text2, Text3, CreatedDate, CreatedBy, Active
                    )
                    VALUES(
                        @RepresentativeId, @username, @Password, @Salt, GETDATE(), @LoggedInUserId, 1
                    )

                END
        END
        
    ELSE

        BEGIN
            --Check user name existance
            IF EXISTS(SELECT 1 FROM [phr].[PatientRepresentativesInfo] WHERE Text1 = @Username AND PatientRepresentativeId != @PatientRepresentativeId)
                BEGIN
                    SET @UserExistsErr = 1
                END
            ELSE 
                BEGIN
                    --Update representative basic info
                    UPDATE PatientRepresentatives
                    SET 
                        PersonRelationshipId    = @PersonRelationshipId,
                        FirstName               = @FirstName, 
                        MiddleInitial           = @MiddleInitial, 
                        LastName                = @LastName,
                        Sex                     = @Sex,
                        DOB                     = @DOB, 
                        MaritalStatusId         = @MaritalStatusId,
                        HomePhone               = @HomePhone,
                        CellPhone               = @CellPhone,                     
                        WorkPhone               = @WorkPhone,
                        OtherPhone              = @OtherPhone,
                        PhonePreferenceTypeId   = @PhonePreferenceTypeId,
                        Email                   = @Email,
                        Fax                     = @Fax, 
                        Address1                = @Address1,
                        Address2                = @Address2,
                        CityId                  = @CityId,
                        StateId                 = @StateId,
                        ZipCode                 = @ZipCode,
                        ZipExtension            = @ZipExtension,
                        ModifiedBy              = @LoggedInUserId,
						ModifiedDate		    = GETDATE()
                    WHERE PatientRepresentativeId = @PatientRepresentativeId
                    
                    --Update representative login info
                    UPDATE PatientRepresentativesInfo
                    SET
                        Text1 = @Username,
						ModifiedDate = GETDATE(),
						ModifiedBy = @LoggedInUserId
                    WHERE PatientRepresentativesInfoId = @PatientRepresentativesInfoId

                    SET @RepresentativeId = @PatientRepresentativeId;

                END
        END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
