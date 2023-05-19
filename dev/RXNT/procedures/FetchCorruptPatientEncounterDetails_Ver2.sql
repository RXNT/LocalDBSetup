SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchCorruptPatientEncounterDetails_Ver2]
  @encType INTEGER,
  @DgID INTEGER = 0
  
AS
BEGIN
	BEGIN TRY
		--Create a temp table to fetch necessaty details
		DECLARE @tempTable TABLE
		(
			[enc_id] int,
			[patient_id] int,
			[enc_text] xml
		)
		IF @DgID = 0
				--If type=EnhancedPatientEncounter
				IF @encType=1
				BEGIN
					--Insert records matching the encounter type into temp table
					INSERT INTO @tempTable
					SELECT [enc_id],[patient_id],[enc_text]
					FROM [dbo].[enchanced_encounter]
					WHERE type='RxNTEncounterModels.EnhancedPatientEncounter'
					
					--fetch the records having corrupted xml data(Patient Id)
					SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id,
					dd.enc_text.value('(/EnhancedPatientEncounter/PatientId)[1]', 'int') as pa_id_xml
					FROM @tempTable dd 
					inner join patients p on p.pa_id=dd.patient_id
					WHERE dd.enc_text.value('(/EnhancedPatientEncounter/PatientId)[1]', 'int') !=dd.patient_id
				    
				END
				--If type=Framework
				ELSE IF @encType=2
				BEGIN
					--Insert records matching the encounter type into temp table
					INSERT INTO @tempTable
					SELECT [enc_id],[patient_id],[enc_text]
					FROM [dbo].[enchanced_encounter]
					WHERE type='RxNTEncounterModels.GenericEncounterFramework.Framework'
					
					--fetch the records having corrupted xml data(Patient Id)
					SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id,
					dd.enc_text.value('(/Framework/PatientId)[1]', 'int') as pa_id_xml
					FROM @tempTable dd 
					inner join patients p on p.pa_id=dd.patient_id
					WHERE dd.enc_text.value('(/Framework/PatientId)[1]', 'int') !=dd.patient_id
				END
				--If type=All encounter types
				ELSE
				BEGIN
					--Insert all records into temp table
					INSERT INTO @tempTable
					SELECT [enc_id],[patient_id],[enc_text]
					FROM [dbo].[enchanced_encounter]
					
					--fetch the records having corrupted xml data(Patient Id)
					SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id,
					dd.enc_text.value('(/EnhancedPatientEncounter/PatientId)[1]', 'int') as pa_id_xml
					FROM @tempTable dd 
					inner join patients p on p.pa_id=dd.patient_id
					WHERE dd.enc_text.value('(/EnhancedPatientEncounter/PatientId)[1]', 'int') !=dd.patient_id
					UNION 
					SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id,
					dd.enc_text.value('(/Framework/PatientId)[1]', 'int') as pa_id_xml
					FROM @tempTable dd 
					inner join patients p on p.pa_id=dd.patient_id
					WHERE dd.enc_text.value('(/Framework/PatientId)[1]', 'int') !=dd.patient_id
					
				END
		ELSE IF @DgID > 0
			BEGIN
					--Insert records matching the encounter type into temp table
					INSERT INTO @tempTable
					SELECT [enc_id],[patient_id],[enc_text]
					FROM [dbo].[enchanced_encounter] ee
					INNER JOIN [dbo].[doctors] d  ON ee.dr_id = d.dr_id
					INNER JOIN [dbo].[doc_groups] dg ON d.dg_id = dg.dg_id
					WHERE d.dg_id = @DgID
					
					--fetch the records having corrupted xml data(Patient Id)
					SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id,
					dd.enc_text.value('(/Framework/PatientId)[1]', 'int') as pa_id_xml
					FROM @tempTable dd 
					inner join patients p on p.pa_id=dd.patient_id
					WHERE dd.enc_text.value('(/Framework/PatientId)[1]', 'int') !=dd.patient_id
				END
				
				
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE(),ERROR_LINE()
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
