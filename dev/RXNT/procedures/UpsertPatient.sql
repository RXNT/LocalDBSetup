SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	13-October-2017
Description			:	Create patient record if not exists based on chart number.
                        Update patient record if exists.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [dbo].[UpsertPatient]	
	@DoctorCompanyId    BIGINT,   
    @dgid               BIGINT,
    @drid               BIGINT, 
    @paprefix           VARCHAR(MAX)    = NULL, 
    @pasuffix           VARCHAR(MAX)    = NULL, 
    @pafirst            VARCHAR(MAX), 
    @pami               VARCHAR(MAX), 
    @palast             VARCHAR(MAX)    = NULL, 
    @paemail            VARCHAR(MAX), 
    @pachart            VARCHAR(MAX),
    @padob              VARCHAR(MAX)    = NULL,                      
    @paaddr1            VARCHAR(MAX), 
    @paaddr2            VARCHAR(MAX), 
    @pacity             VARCHAR(MAX), 
    @pastate            VARCHAR(MAX),
    @pazip              VARCHAR(MAX), 
    @paphone            VARCHAR(MAX), 
    @pasex              VARCHAR(MAX),
    @paflag             TINYINT			= NULL, 
    @passn              VARCHAR(MAX), 
    @painstype          TINYINT         = NULL, 
    @pracetype          TINYINT         = NULL, 
    @paethn             TINYINT         = NULL, 
    @palang             INT             = NULL,
    @add_by_user        BIGINT          = NULL
AS

DECLARE @PatientId BIGINT = 0

SELECT @PatientId = P.PA_ID 
	FROM DOC_GROUPS D1 
		INNER JOIN DOC_COMPANIES DC on D1.DC_ID = DC.DC_ID
        INNER JOIN DOC_GROUPS D2 on DC.DC_ID = D2.DC_ID 
        INNER JOIN  PATIENTS P ON D2.DG_ID= P.DG_ID
     WHERE 
		D1.DC_ID = @DoctorCompanyId AND
        pa_ssn LIKE @pachart 

IF @@ROWCOUNT = 0
     
	BEGIN

		INSERT INTO PATIENTS(
            dg_id, dr_id, pa_prefix, pa_suffix, pa_first, pa_middle, pa_last, pa_ssn, pa_dob, 
            pa_address1, pa_address2, pa_city, pa_state, pa_zip, pa_phone, pa_sex, pa_flag, 
            pa_ext_ssn_no, pa_ins_type, pa_race_type, pa_ethn_type, pref_lang, pa_email, add_by_user
        ) 
        VALUES (
            @dgid, @drid, @paprefix, @pasuffix , @pafirst, @pami, @palast, @pachart, @padob,
            @paaddr1, @paaddr2, @pacity, @pastate,  @pazip, @paphone, @pasex, @paflag,
            @passn, @painstype, @pracetype, @paethn, @palang, @paemail, @add_by_user
        )

        SELECT CAST(scope_identity() AS int)
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
                    DR_ID           =   @drid, 
                    PA_PREFIX       =   @paprefix, 
                    PA_SUFFIX       =   @pasuffix, 
                    PA_FIRST        =   @pafirst, 
                    PA_MIDDLE       =   @pami, 
                    PA_LAST         =   @palast, 
                    pa_email        =   @paemail, 
                    PA_SSN          =   @pachart,
                    PA_DOB          =   @padob,                      
                    PA_ADDRESS1     =   @paaddr1, 
                    PA_ADDRESS2     =   @paaddr2, 
                    PA_CITY         =   @pacity, 
                    PA_STATE        =   @pastate,
                    PA_ZIP          =   @pazip, 
                    PA_PHONE        =   @paphone, 
                    PA_SEX          =   @pasex,
                    PA_FLAG         =   @paflag, 
                    pa_ext_ssn_no   =   @passn, 
                    pa_ins_type     =   @painstype, 
                    pa_race_type    =   @pracetype, 
                    pa_ethn_type    =   @paethn, 
                    pref_lang       =   @palang,
                    record_modified_date    =   GETDATE() 
                WHERE PA_ID = @PatientId
                
                SELECT CAST(@PatientId AS int)
                RETURN
            END

        ELSE
            BEGIN
                SELECT CAST(0 AS int)
                RETURN
            END
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
