SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[ManualMerge]

AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION 
		DECLARE @patientsInfo CURSOR
		DECLARE @prm_patientId INT
		DECLARE @prm_patient_status BIT
		DECLARE @sec_PatientId INT
		DECLARE @sec_patient_status BIT
		DECLARE @log_Path VARCHAR(50)
		DECLARE @errormsg VARCHAR(MAX)


		SET @patientsInfo = CURSOR FOR
			Select 
			[Primary_PatientId],
			[Primary_Patient_Active],
			[Secondary_PatientId],
			[Secondary_Patient_Active]
			FROM Patient_Merge_Stage

		OPEN @patientsInfo
		FETCH NEXT
			FROM @patientsInfo INTO @prm_patientId,@prm_patient_status, @sec_PatientId,@sec_patient_status
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF((@prm_patient_status IS NULL OR @prm_patient_status = '') AND (@sec_patient_status is null or @sec_patient_status = ''))
				BEGIN
					SET @errormsg='Primary and Secondary Patients Status should not be Null Or Empty or zero! Primary PatientId:'+CONVERT(VARCHAR(50),@prm_patientId)+', Secondary PatientId:'+CONVERT(VARCHAR(50),@sec_PatientId)+''
				END
			ELSE
				BEGIN
					IF(@prm_patient_status=1 AND @sec_patient_status=1)
						BEGIN
							SET @errormsg='Primary and Secondary Patients Status should not be Active! Primary PatientId:'+CONVERT(VARCHAR(50),@prm_patientId)+', Secondary PatientId:'+CONVERT(VARCHAR(50),@sec_PatientId)+''
						END
					ELSE
						BEGIN
							IF(@prm_patient_status=1)
								BEGIN
									EXEC [dbo].[mergePatients_New] @prm_patientId,@sec_PatientId
									INSERT INTO [dbo].[ManualMergedPatients] ([PrimaryPatientId],[SecondaryPatientId])
									VALUES(@prm_patientId,@sec_PatientId)
								END
							ELSE 
							IF(@sec_patient_status=1)
								BEGIN
									EXEC [dbo].[mergePatients_New] @sec_PatientId,@prm_patientId
									INSERT INTO [dbo].[ManualMergedPatients] ([PrimaryPatientId],[SecondaryPatientId])
									VALUES(@sec_PatientId,@prm_patientId)
								END
						
						END
				END   
			FETCH NEXT
			FROM @patientsInfo INTO @prm_patientId,@prm_patient_status, @sec_PatientId,@sec_patient_status
		END
		CLOSE @patientsInfo
		DEALLOCATE @patientsInfo
	COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
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
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','ManualMerge','Error on manual merge',ERROR_LINE ())				   
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
