SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addNewEncounter] 
  @definition XML,  
  @enc_name VARCHAR(125),
  @speciality VARCHAR(125)
  
AS    
  BEGIN
	DECLARE @nextID INTEGER
	DECLARE @encType VARCHAR(225)
	DECLARE @enclstID INTEGER	
	DECLARE @chkType VARCHAR(225)
	DECLARE @chkEncType INTEGER 
	DECLARE @err_message VARCHAR(225)
	
    SET @nextID = (SELECT TOP 1 model_defn_id+1 FROM encounter_model_definitions ORDER BY model_defn_id DESC)
    
    SET @encType = 'RxNTEncounterModels.GenericEncounterFramework.Framework_'+convert(VARCHAR(20),@nextID)   
	
	SET @chkType = (SELECT [type] FROM [encounter_model_definitions] WHERE [type] = @encType)
					
	INSERT INTO [dbo].[encounter_model_definitions]
		   ([type]
		   ,[definition])
	 VALUES
		   (@encType,
		   @definition)	         
    
	SET @enclstID = (SELECT max(enc_lst_id)+1 FROM encounter_types)	
	
	SET @chkEncType = (SELECT COUNT([enc_type]) FROM [encounter_types] WHERE [enc_name] = @enc_name AND [speciality] = @speciality)
	
	IF (@chkEncType <= 0) 
		BEGIN
		INSERT INTO [dbo].[encounter_types]
			   ([enc_lst_id]
			   ,[enc_name]
			   ,[enc_type]
			   ,[speciality])
		 VALUES
			   (@enclstID,
				@enc_name,
				@encType,
				@speciality)
		END
	--ELSE
		--BEGIN
		--SET @err_message = @enc_name + ' IS ALREADY PRESENT IN THE DATABASE'
		--		 RAISERROR (@err_message,10, 1) 	
		---END
		
	
		select * from [encounter_model_definitions] where [type] = @encType
	
		select * from [encounter_types] where [enc_lst_id] = @enclstID
			           
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
