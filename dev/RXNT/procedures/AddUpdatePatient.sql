SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddUpdatePatient] 
	(@pa_id INT,
	 @paprefix VARCHAR(10)= NULL,
	 @pasuffix VARCHAR(10)= NULL,
	 @pafirst VARCHAR(50),
	 @pami VARCHAR(50),
	 @palast VARCHAR(50)= NULL,
	 @pachart VARCHAR(50),
	 @padob datetime=NULL,
	 @paaddr1 VARCHAR(100),
	 @paddr2 VARCHAR(100),
	 @pacity VARCHAR(50),
	 @pastate VARCHAR(2),
	 @pazip VARCHAR(20),
	 @paphone VARCHAR(20),
	 @pasex VARCHAR(1),
	 @paflag TINYINT= NULL,
	 @passn VARCHAR(25)=NULL,
	 @painstype TINYINT= NULL,
	 @parace TINYINT= NULL,
	 @paethn TINYINT= NULL,
	 @palang SMALLINT= NULL,
	 @paemail VARCHAR(80)=NULL
	 )
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS(SELECT pa_id FROM patients WITH(NOLOCK) WHERE pa_id=@pa_id)
				BEGIN
					UPDATE PATIENTS SET pa_prefix=@paprefix,pa_suffix=@pasuffix,pa_first=@pafirst,pa_middle=@pami,pa_last=@palast,pa_ssn=@pachart,pa_dob=@padob,
					pa_address1=@paaddr1,pa_address2=@paddr2,pa_city=@pacity,pa_state=@pastate,pa_zip=@pazip,pa_phone=@paphone,pa_sex=@pasex,pa_flag=@paflag,
					pa_ext_ssn_no=@passn,pa_ins_type=@painstype,pa_race_type=@parace,pa_ethn_type=@paethn,pref_lang=@palang,pa_email=@paemail
					WHERE pa_id=@pa_id
				END
			ELSE
				BEGIN
					INSERT INTO PATIENTS(pa_prefix, pa_suffix, pa_first, pa_middle, pa_last, pa_ssn, pa_dob, pa_address1, pa_address2, 
					pa_city, pa_state, pa_zip, pa_phone, pa_sex, pa_flag, pa_ext_ssn_no, pa_ins_type, pa_race_type, pa_ethn_type, pref_lang, pa_email) 
					VALUES (@paprefix, @pasuffix , @pafirst, @pami, @palast, @pachart, @padob, @paaddr1, @paddr2, @pacity, @pastate,  @pazip, @paphone, @pasex,
					@paflag, @passn, @painstype, @parace, @paethn, @palang, @paemail)
				END	
		COMMIT	
	END TRY
	BEGIN CATCH
		ROLLBACK -- Rollback TRANSACTION
		
		DECLARE @ErrorMessage AS NVARCHAR(4000),@ErrorSeverity AS INT,@ErrorState AS INT;
		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','SingleSignOnProcessor','',ERROR_LINE ())				   
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
