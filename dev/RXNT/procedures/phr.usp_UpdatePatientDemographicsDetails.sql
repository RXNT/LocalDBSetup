SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_UpdatePatientDemographicsDetails]
	(
	@PatientId			BIGINT,
	@PreferredPhone		BIGINT,
	@HomePhone		VARCHAR(50),
	
	
	@WorkPhone		VARCHAR(50),
	@OtherPhone		VARCHAR(50),
	@CellPhone		VARCHAR(50),
	@Email			VARCHAR(100),
	@CommunicationPreferences	BIGINT,
	@TimeZone		VARCHAR(10),
	@PreferredStartTime Time(7),
	@PreferredEndTime Time(7),
	@FirstName		VARCHAR(50),
	@LastName		VARCHAR(50),
	@MiddleName		VARCHAR(50),
	@DateOfBirth	SMALLDATETIME,
	@Address1		VARCHAR(100),
	@Address2		VARCHAR(100),
	@ZipCode		VARCHAR(50),
	@City			VARCHAR(50),
	@PatientSSN		VARCHAR(100),
	@Sex		VARCHAR(50),
	@State		VARCHAR(2),
	@PatientRace		TinyINT,
	@MaritalStatus		BIGINT,
	@PatientEthnicity		TinyINT,
	@EmploymentStatus		BIGINT,
	@Language		TinyINT
	
	
)
AS
BEGIN
	
	
	UPDATE patients SET  
	pa_phone = @HomePhone,
	pa_email = @Email,
	pa_first=@FirstName,
	pa_last=@LastName,
	pa_middle=@MiddleName,
	pa_dob=@DateOfBirth,
	pa_address1=@Address1,
	pa_address2=@Address2,
	pa_zip=@ZipCode,
	pa_city=@City,
	pa_state=@State,
	pa_ssn=@PatientSSN,
	pa_sex=@Sex,
	 pa_ethn_type=@PatientEthnicity,
	pref_lang=@Language,
	pa_race_type  =@PatientRace
	where pa_id = @PatientId 
	
	
	UPDATE patient_extended_details  SET  
	pref_phone = @PreferredPhone,
	work_phone= @WorkPhone,
	cell_phone= @CellPhone,
	other_phone=@OtherPhone,
	comm_pref=@CommunicationPreferences,
	time_zone=@TimeZone,
	pref_end_time = @PreferredEndTime,
	pref_start_time = @PreferredStartTime,
	marital_status=@MaritalStatus,
	empl_status=@EmploymentStatus
	where pa_id = @PatientId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
