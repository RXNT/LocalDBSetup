SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Nambi
Create date			:	26-APR-2018
Description			:	Create patient record if not exists based on chart number.
                        Update patient record if exists.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [hospice].[SaveExternalPatient]
	@RxNTPatientId				BIGINT=0 OUTPUT,
	@DoctorCompanyId			BIGINT,   
    @DoctorGroupId				BIGINT,
    @DoctorId					BIGINT, 
    @Prefix						VARCHAR(MAX)= NULL, 
    @Suffix						VARCHAR(MAX)= NULL, 
    @FirstName					VARCHAR(MAX), 
    @MiddleName					VARCHAR(MAX), 
    @LastName					VARCHAR(MAX)= NULL, 
    @Email						VARCHAR(MAX)=NULL, 
    @ChartNo					VARCHAR(MAX),
    @DOB						VARCHAR(MAX)= NULL,                      
    @Address1					VARCHAR(MAX), 
    @Address2					VARCHAR(MAX), 
    @City						VARCHAR(MAX), 
    @State						VARCHAR(MAX),
    @Zip						VARCHAR(MAX), 
    @Phone						VARCHAR(MAX), 
    @Sex						VARCHAR(MAX),
    @Flag						TINYINT= NULL, 
    @SSN						VARCHAR(MAX)=NULL, 
    @InsuranceType				TINYINT= NULL, 
    @RaceType					TINYINT= NULL, 
    @Ethinicity					TINYINT= NULL, 
    @Language					INT= NULL,
    @AddedBy					BIGINT= NULL
AS

DECLARE @PatientId BIGINT = 0

SELECT @PatientId = P.PA_ID 
	FROM DOC_GROUPS D1 
		INNER JOIN DOC_COMPANIES DC on D1.DC_ID = DC.DC_ID
        INNER JOIN DOC_GROUPS D2 on DC.DC_ID = D2.DC_ID 
        INNER JOIN  PATIENTS P ON D2.DG_ID= P.DG_ID
     WHERE 
		D1.DC_ID = @DoctorCompanyId AND
        pa_ssn LIKE @ChartNo 

IF @@ROWCOUNT = 0
     
	BEGIN

		INSERT INTO PATIENTS(
            dg_id, dr_id, pa_prefix, pa_suffix, pa_first, pa_middle, pa_last, pa_ssn, pa_dob, 
            pa_address1, pa_address2, pa_city, pa_state, pa_zip, pa_phone, pa_sex, pa_flag, 
            pa_ext_ssn_no, pa_ins_type, pa_race_type, pa_ethn_type, pref_lang, pa_email, add_by_user
        ) 
        VALUES (
            @DoctorGroupId, @DoctorId, @Prefix, @Suffix , @FirstName, @MiddleName, @LastName, @ChartNo, @DOB,
            @Address1, @Address2, @City, @State,  @Zip, @Phone, @Sex, @Flag,
            @SSN, @InsuranceType, @RaceType, @Ethinicity, @Language, @Email, @AddedBy
        )

        SELECT @RxNTPatientId = SCOPE_IDENTITY()
        RETURN

	END
	
ELSE
	BEGIN
        IF(EXISTS(

            SELECT DG.DC_ID 
            FROM PATIENTS P 
                INNER JOIN DOC_GROUPS DG ON  P.DG_ID = DG.DG_ID 
            WHERE 
                P.PA_ID     =  @PatientId AND 
                DG.DC_ID    =  @DoctorCompanyId ))

            BEGIN
                UPDATE PATIENTS 
                SET 
                    DR_ID           =   @DoctorId, 
                    PA_PREFIX       =   @Prefix, 
                    PA_SUFFIX       =   @Suffix, 
                    PA_FIRST        =   @FirstName, 
                    PA_MIDDLE       =   @MiddleName, 
                    PA_LAST         =   @LastName, 
                    pa_email        =   @Email, 
                    PA_SSN          =   @ChartNo,
                    PA_DOB          =   @DOB,                      
                    PA_ADDRESS1     =   @Address1, 
                    PA_ADDRESS2     =   @Address2, 
                    PA_CITY         =   @City, 
                    PA_STATE        =   @State,
                    PA_ZIP          =   @Zip, 
                    PA_PHONE        =   @Phone, 
                    PA_SEX          =   @Sex,
                    PA_FLAG         =   @Flag, 
                    pa_ext_ssn_no   =   @SSN, 
                    pa_ins_type     =   @InsuranceType, 
                    pa_race_type    =   @RaceType, 
                    pa_ethn_type    =   @Ethinicity, 
                    pref_lang       =   @Language,
                    record_modified_date    =   GETDATE() 
                WHERE PA_ID = @PatientId
                
                SELECT @RxNTPatientId = @PatientId
                RETURN
            END

        ELSE
            BEGIN
                SELECT @RxNTPatientId = 0
                RETURN
            END
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
