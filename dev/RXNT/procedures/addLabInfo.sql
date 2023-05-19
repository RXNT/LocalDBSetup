SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addLabInfo] 
  @labName VARCHAR(100),
  @sendApp VARCHAR(20),
  @recvFacility VARCHAR(50),
  @dgID INTEGER,
  @accountkey VARCHAR(50)=NULL,
  @interfaceName VARCHAR(50)=NULL
  
AS    
  BEGIN
	DECLARE @nextID INTEGER
	DECLARE @ppID	INTEGER
	DECLARE @cntLab INTEGER
	DECLARE @labParticipantID INTEGER
	
	SET @cntlab = (SELECT count(*) FROM lab_partners WHERE partner_sendapp_text = @sendApp)

    SET @nextID = (SELECT TOP 1 lab_partner_id+1 FROM lab_partners ORDER BY lab_partner_id DESC)

    SET @ppID = (SELECT max(partner_participant)+1 FROM lab_partners)
	
	IF (@cntlab = 0)
		BEGIN	
		
		INSERT INTO [dbo].[lab_partners]
           ([lab_partner_id]
           ,[partner_name]
           ,[partner_address]
           ,[partner_city]
           ,[partner_state]
           ,[partner_zip]
           ,[partner_phone]
           ,[partner_fax]
           ,[partner_participant]
           ,[partner_enabled]
           ,[partner_sendapp_text]
           )
		VALUES
           (@nextID 
           ,@labName 
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,@ppID
           ,1
           ,@sendApp
           ) 
            		
		END
    
	SET @labParticipantID = (SELECT [partner_participant] FROM [lab_partners] WHERE [partner_sendapp_text] = @sendApp)
	
	IF (@labParticipantID != '')
		BEGIN
		INSERT INTO [doc_groups_lab_info]
			   ([dg_id]
			   ,[dg_lab_id]
			   ,[lab_participant]
			   ,[name]
			   ,account_key)
		 VALUES
			   (@dgID 
			   ,@recvFacility
			   ,@labParticipantID
			   ,@interfaceName
			   ,@accountkey)		
		END
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
