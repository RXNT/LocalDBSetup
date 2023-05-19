SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		:	Ramakrishna	
-- Create date	:	Feb-23-2017
-- Description	:	This stored procedure userd for update the encounter xmls
-- Modified By	: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [support].[UpdateEncounterFormsXml]
	@enc_name		varchar(255),
	@Xml			XML,
	@Speciality		VARCHAR(255)
AS
BEGIN
       DECLARE @enc_type VARCHAR(100)
       DECLARE @model_defn_id BIGINT
       DECLARE @enc_lst_id BIGINT
	IF LEN(@enc_name) > 0
	BEGIN
		select @enc_type = enc_type from encounter_types where enc_name = @enc_name and speciality = @Speciality
		PRINT @enc_type
		IF LEN(@enc_type) > 0
		BEGIN
			update encounter_model_definitions set definition=@Xml,json_definition=NULL
			where type=@enc_type
			PRINT @enc_name +' Updated.' 
		END
		ELSE
		BEGIN 
			INSERT INTO [dbo].[encounter_model_definitions]
			   ([type]
			   ,[definition])
			VALUES
			   (''
			   ,@Xml)
			SET @model_defn_id=SCOPE_IDENTITY()
			
			SET @enc_type =  'RxNTEncounterModels.GenericEncounterFramework.Framework_'+CAST(@model_defn_id AS VARCHAR(50))
			UPDATE [dbo].[encounter_model_definitions] 
			SET type = @enc_type
			WHERE model_defn_id=@model_defn_id

			SELECT @enc_lst_id = MAX(ISNULL(enc_lst_id,0))+1
			FROM [dbo].[encounter_types]
			INSERT INTO [dbo].[encounter_types]
			   ([enc_lst_id]
			   ,[enc_name]
			   ,[enc_type]
			   ,[speciality]
			   ,[encounter_version]
			   ,active)
			 VALUES
			   (@enc_lst_id
			   ,@enc_name
			   ,@enc_type
			   ,ISNULL(@Speciality,'General')
			   ,'v1.1'
			   ,1)


			PRINT @enc_name +' Created.' 
		END
	END		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
