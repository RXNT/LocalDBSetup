SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[UpdateEncounter] 
  @definition XML,  
  @enc_name VARCHAR(125) 
  
AS    
  BEGIN		
	DECLARE @encType VARCHAR(225)	
	DECLARE @chkEncID INTEGER
	DECLARE @chkType VARCHAR(225)	
	DECLARE @err_message VARCHAR(225)
	
    SET @encType = (SELECT [enc_type] FROM [encounter_types] WHERE [enc_name] = @enc_name) 
	
	SET @chkType = (SELECT [type] FROM [encounter_model_definitions] WHERE [type] = @encType)  
	
	SET @chkEncID = (SELECT  SUBSTRING(type,CHARINDEX('_', type)+1, LEN(type) ) from encounter_model_definitions where [type] = @encType)
		
	
	IF (@chkType IS NOT NULL or @chkType != '') 
		BEGIN
				
			UPDATE [encounter_model_definitions]
				SET definition = @definition
			WHERE [type] = @encType AND model_defn_id = @chkEncID
			
			SELECT * FROM [encounter_model_definitions] WHERE [type] = @encType AND model_defn_id = @chkEncID
	
			SELECT * FROM [encounter_types] WHERE [enc_name] = @enc_name
		
		END		
	 ELSE
		BEGIN
		
			SET @err_message = 'Encounter "' + @enc_name + '" is not in the database, Please confirm the encounter name'
					 RAISERROR (@err_message,10, 1) 	
		
		END			
			           
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
