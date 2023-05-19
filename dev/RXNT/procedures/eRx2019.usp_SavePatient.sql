SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [eRx2019].[usp_SavePatient]
@DoctorGroupId BIGINT,
@DoctorId BIGINT,
@PatientFirstName VARCHAR(50)=NULL,
@PatientMiddleName VARCHAR(50)=NULL,
@PatientLastName VARCHAR(50),
@PatientDOB DATETIME,
@PatientGender VARCHAR(1)=NULL,
@PatientAddressLine1 VARCHAR(100),
@PatientAddressLine2 VARCHAR(100)=NULL,
@PatientCity VARCHAR(100)=NULL,
@PatientState VARCHAR(50)=NULL,
@PatientZipCode VARCHAR(50)=NULL,
@PatientPhone VARCHAR(50)=NULL,
@CreatedBySystem VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @PatientId BIGINT,@Prefix VARCHAR(50),@Suffix VARCHAR(50),@BirthName VARCHAR(50),@ChartNo VARCHAR(50),@IsReferredPatient BIT,@PrimaryDoctorId BIGINT,@PatientFlag INT, @PatientSSN VARCHAR(50), @InsuranceType TINYINT, @PatientRace TINYINT, @PatientEthnicity TINYINT, @Language TINYINT, @Email VARCHAR(50), @OwnerType VARCHAR(50)
    INSERT INTO PATIENTS(dg_id, dr_id, pa_prefix, pa_suffix, pa_first, pa_middle, pa_last, pa_birthName, pa_ssn, pa_dob, pa_address1, pa_address2, pa_city, pa_state, pa_zip, pa_phone, pa_sex, pa_flag, pa_ext_ssn_no, pa_ins_type, pa_race_type, pa_ethn_type, pref_lang, pa_email,add_by_user,add_date, OwnerType) 
    VALUES (@DoctorGroupId, @DoctorId, @Prefix, @Suffix , ISNULL(@PatientFirstName,''), ISNULL(@PatientMiddleName,''), ISNULL(@PatientLastName,''), @BirthName, ISNULL(@ChartNo,''), @PatientDOB, ISNULL(@PatientAddressLine1,''), ISNULL(@PatientAddressLine2,''), ISNULL(@PatientCity,''), ISNULL(@PatientState,''),  ISNULL(@PatientZipCode,''), ISNULL(@PatientPhone,''), ISNULL(@PatientGender,''), @PatientFlag, ISNULL(@PatientSSN,''), @InsuranceType, @PatientRace, @PatientEthnicity, @Language, @Email,@PrimaryDoctorId,GETDATE(), @OwnerType);
	SET @PatientId=SCOPE_IDENTITY()
	
	INSERT INTO PATIENT_EXTENDED_DETAILS(PA_ID,pa_ext_ref, prim_dr_id, dr_id
	,created_by_system) 
	VALUES (@PatientId,ISNULL(@IsReferredPatient,0), ISNULL(@PrimaryDoctorId,0), ISNULL(@DoctorId,0)
	, @CreatedBySystem)--'TRANCEIVER_REFILL_REQUEST') 
                          
	RETURN @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
