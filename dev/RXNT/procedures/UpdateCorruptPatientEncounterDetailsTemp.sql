SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[UpdateCorruptPatientEncounterDetailsTemp]
  @encIds VARCHAR(MAX)  
AS 
BEGIN
	--Temp table to hold all encounter ids to be updated
	DECLARE @tempTable TABLE
	(
		[index] INT IDENTITY(1,1) ,
		[enc_id] INT
	)
	--declare variables
	DECLARE @index INT
	DECLARE @rowCount INT
	DECLARE @encId INT
	DECLARE @newXml xml
	DECLARE @newVal VARCHAR(MAX)
	DECLARE @type VARCHAR(MAX)
	DECLARE @typeOfEnc VARCHAR(MAX)
	DECLARE @PatientId VARCHAR(MAX)
	--fetch the comma separated encounter ids into temp table
	INSERT INTO @tempTable
	SELECT * FROM dbo.[fnSplitEncounterIds](@encIds,',')
	SET @rowCount=@@ROWCOUNT
	SET @index=1
	--loop through each encounter id
	WHILE(@index<=@rowCount)
	BEGIN
		--fetch encounter id
		SELECT @encId=enc_id FROM @tempTable WHERE [index]=@index
		--fetch xml,patient id and type
		SELECT @newXml= [enc_text],@PatientId=[patient_id],@type=[type]
		FROM [dbo].temp_enchanced_encounters
		WHERE enc_id=@encId		
		--fetch the encounter type for updating
		SET @typeOfEnc= REVERSE(SUBSTRING(REVERSE(@type), 1, 
               CHARINDEX('.', REVERSE(@type)) - 1))
		IF @typeOfEnc='Framework'
		BEGIN
			--update xml
			SET @NewXml.modify('
			  replace value of (/Framework/PatientId[1]/text())[1]
			  with     (sql:variable("@PatientId"))
			')
			SET @newVal = cast(@newXml as VARCHAR(MAX))
			--update xml into data table
			UPDATE [dbo].temp_enchanced_encounters
			SET [enc_text]=@newVal
			WHERE enc_id=@encId	
		END
		ELSE IF @typeOfEnc='EnhancedPatientEncounter'
		BEGIN
			--update xml
			SET @NewXml.modify('
			  replace value of (/EnhancedPatientEncounter/PatientId[1]/text())[1]
			  with     (sql:variable("@PatientId"))
			')
			SET @newVal = cast(@newXml as VARCHAR(MAX))
			--update xml into data table
			UPDATE [dbo].temp_enchanced_encounters
			SET [enc_text]=@newVal
			WHERE enc_id=@encId	
		END
		--increment the index
		SET @index=@index+1
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
