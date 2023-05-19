SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ============================================= 
-- Author:  JahabarYusuff M 
-- Create date: 09-Jul-2020 
-- Description: sync/update patient demographics info 
-- =============================================
CREATE PROCEDURE [ehr].[SyncPatientIntakeFormData] ( 
@PatientId bigint,
@DoctorCompanyId                                                bigint, 
@RowCount                                                       int output, 
@DoctorId                                                       bigint, 
@Firstname                                                      varchar(50)= NULL, 
@Lastname                                                       varchar(50) = NULL, 
@Middlename                                                     varchar(50), 
@PreferredName varchar(50) = NULL,
@Email                                                          varchar(80) = NULL, 
@Dob                                                            datetime = NULL, 
@Address1                                                       varchar(100), 
@Address2                                                       varchar(100), 
@City                                                           varchar(50), 
@State                                                          varchar(2), 
@Zip                                                            varchar(20), 
@Sex                                                            varchar(1) , 
@SSN                                                            varchar(25) = NULL, 
@Race                                                           smallint = NULL, 
@Ethnicity                                                      smallint = NULL, 
@Language                                                       smallint = NULL, 
@HomePhone                                                      varchar(50), 
@CellPhone                                                      varchar(50), 
@WorkPhone                                                      varchar(50)= NULL, 
@OtherPhone                                                     varchar(50)= NULL, 
@PreferredPhone                                                 smallint = NULL , 
@TimeZone                                                       varchar(6)= NULL, 
@EmergencyContactName                                           varchar(35)= NULL, 
@EmergencyContactPhone                                          varchar(20)= NULL, 
@EmergencyContactRelationship                                   varchar(3)= NULL, 
@MaritalStatus                                                  smallint = 0, 
@CommunicationPreferences                                       smallint = NULL, 
@EmploymentStatus                                               smallint = 0, 
@SexualOrientation                                              int = NULL, 
@GenderIdentity                                                 int = NULL ) 
AS 
  BEGIN 
    --IF EXISTS(SELECT DG.DC_ID FROM PATIENTS P WITH(NOLOCK) INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON  P.DG_ID = DG.DG_ID WHERE P.PA_ID = @PatientId  AND DG.DC_ID = @DoctorCompanyId)
    IF EXISTS 
    ( 
           SELECT 1 
           FROM   patients p WITH(nolock) 
           WHERE  p.pa_id = @PatientId) 
    BEGIN 
      UPDATE patients 
      SET    pa_first = @Firstname, 
             pa_middle = @Middlename, 
             pa_last = @Lastname, 
             pa_dob = @Dob, 
             pa_address1 = @Address1, 
             pa_address2 = @Address2, 
             pa_city = @City, 
             pa_state = @State, 
             pa_zip = @Zip, 
             pa_phone = @HomePhone, 
             pa_sex = @Sex, 
             pa_ext_ssn_no = @SSN, 
             pa_race_type = @Race, 
             pa_ethn_type = @Ethnicity, 
             pref_lang = @Language, 
             pa_email = @Email 
      WHERE  pa_id = @PatientId 
      SET    @RowCount = @@ROWCOUNT; 
     
    end 
    ELSE 
    BEGIN 
      SET @RowCount = 0; 
    end 
    DECLARE @patientExtExist int = 0; 
    select @patientExtExist = 1 
    FROM   patient_extended_details p WITH(nolock) 
    WHERE  p.pa_id = @PatientId 
    -- Patient Extended Details Update/insert 
    IF(@patientExtExist>0 
    AND 
    @RowCount>0) 
    BEGIN 
      UPDATE patient_extended_details 
      SET    cell_phone = @CellPhone , 
             work_phone = @WorkPhone, 
             other_phone = @OtherPhone, 
             pref_phone = @PreferredPhone, 
             comm_pref = @CommunicationPreferences, 
             time_zone = @TimeZone, 
             marital_status = @MaritalStatus, 
             empl_status = @EmploymentStatus, 
             emergency_contact_first = @EmergencyContactName, 
             emergency_contact_phone = @EmergencyContactPhone, 
             emergency_contact_relationship = @EmergencyContactRelationship, 
             pa_nick_name = @PreferredName, 
			 pa_sexual_orientation = @SexualOrientation, 
             pa_gender_identity = @GenderIdentity,
             last_modified_date = getdate(), 
             last_modified_by = @DoctorId 
      WHERE  pa_id = @PatientId 
      SET    @RowCount = @RowCount + @@ROWCOUNT; 
     
    end 
    ELSE 
    BEGIN 
      INSERT INTO patient_extended_details 
                  ( 
                              pa_id, 
                              pa_ext_ref, 
                              prim_dr_id, 
                              dr_id, 
                              cell_phone, 
                              work_phone, 
                              other_phone, 
                              pref_phone, 
                              comm_pref, 
                              time_zone, 
                              marital_status, 
                              empl_status, 
                              emergency_contact_first, 
                              emergency_contact_phone, 
                              emergency_contact_relationship, 
							   pa_nick_name , 
			 pa_sexual_orientation, 
             pa_gender_identity ,
                              last_modified_date, 
                              last_modified_by 
                  ) 
                  VALUES 
                  ( 
                              @PatientId, 
                              0,0,0, 
                              @CellPhone, 
                              @WorkPhone, 
                              @OtherPhone, 
                              @PreferredPhone, 
                              @CommunicationPreferences, 
                              @TimeZone, 
                              @MaritalStatus, 
                              @EmploymentStatus, 
                              @EmergencyContactName, 
                              @EmergencyContactPhone, 
                              @EmergencyContactRelationship, 
							  @PreferredName,
							  @SexualOrientation,
							  @GenderIdentity,
                              getdate(), 
                              @DoctorId 
                  ) 
      SET @RowCount = @RowCount + 1; 
    end 
  END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
