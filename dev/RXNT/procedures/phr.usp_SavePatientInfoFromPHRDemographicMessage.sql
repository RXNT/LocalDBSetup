SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SavePatientInfoFromPHRDemographicMessage] (
		@PatientId BIGINT,
		@LastName VARCHAR(50),
		@MiddleName VARCHAR(50),
		@FirstName VARCHAR(50),
		@NickName VARCHAR(50),
		@Sex VARCHAR(1),
		@DOB SMALLDATETIME,
		@Address1 VARCHAR(100),
		@Address2 VARCHAR(100),
		@Zip VARCHAR(50),
		@City VARCHAR(50),
		@State VARCHAR(2),
		@SexualOrientaion TINYINT,
		@SexualOrientationDetail VARCHAR(200),
		@Ethnicity TINYINT,
		@GenderIdentity TINYINT,
		@GenderIdentityDetail VARCHAR(200),
		@EmploymentStatus TINYINT,
		@MaritalStatus TINYINT,
		@RaceCategory TINYINT,
		@PreferredPhone TINYINT,
		@HomePhone VARCHAR(50),
		@WorkPhone VARCHAR(50),
		@CellPhone VARCHAR(50),
		@OtherPhone VARCHAR(50),
		@CommunicationPreferences TINYINT,
		@Suffix VARCHAR(10),
		@PreferredLanguageId SMALLINT,
        @PreviousName VARCHAR(50)
	) AS BEGIN
UPDATE patients
SET pa_phone = @HomePhone,
	pa_first = @FirstName,
	pa_last = @LastName,
	pa_middle = @MiddleName,
	pa_sex = @Sex,
	pa_dob = @DOB,
	pa_address1 = @Address1,
	pa_address2 = @Address2,
	pa_zip = @Zip,
	pa_city = @City,
	pa_state = @State,
	pa_ethn_type = @Ethnicity,
	pa_race_type = @RaceCategory,
	pa_suffix = @Suffix,
	pref_lang = @PreferredLanguageId
where pa_id = @PatientId
UPDATE patient_extended_details
SET pa_nick_name = @NickName,
	pref_phone = @PreferredPhone,
	work_phone = @WorkPhone,
	cell_phone = @CellPhone,
	other_phone = @OtherPhone,
	comm_pref = @CommunicationPreferences,
	marital_status = @MaritalStatus,
	empl_status = @EmploymentStatus,
	pa_sexual_orientation = @SexualOrientaion,
	pa_sexual_orientation_detail = @SexualOrientationDetail,
	pa_gender_identity = @GenderIdentity,
	pa_gender_identity_detail = @GenderIdentityDetail,
    pa_previous_name = @PreviousName
where pa_id = @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
