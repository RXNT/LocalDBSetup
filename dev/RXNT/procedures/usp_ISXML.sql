SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC [dbo].[usp_ISXML]
(
@enc_id INT,
@is_xml VARCHAR(25) OUTPUT
)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @enc_text_XML XML
	SET @is_xml = 'Valid_XML'
	BEGIN TRY
		-- Generate divide-by-zero error.
		IF EXISTS (SELECT * FROM enchanced_encounter WHERE enc_id = @enc_id)
			SELECT @enc_text_XML = CONVERT(XML,enc_text) FROM enchanced_encounter WITH (NOLOCK) WHERE enc_id = @enc_id
		ELSE 
			SET @is_xml = 'No Record Found'
	END TRY
	BEGIN CATCH
		-- Execute error retrieval routine.
		SELECT @is_xml = 'DR_ID: ' +CONVERT(VARCHAR(MAX),dr_id) + ' InValid_XML'  FROM enchanced_encounter WITH (NOLOCK) WHERE enc_id = @enc_id
	END CATCH; 
End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
