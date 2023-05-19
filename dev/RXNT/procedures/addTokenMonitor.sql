SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addTokenMonitor] @DRID INTEGER
AS
	IF EXISTS(SELECT DR_ID FROM DOCTORS WHERE DR_ID=@DRID) AND NOT EXISTS (SELECT DR_ID FROM doc_token_info WHERE DR_ID=@DRID)
	BEGIN
		INSERT INTO [doc_token_info]([dr_id],[stage],[comments],[shipping_address1],[shipping_city],shipping_state,shipping_zip,shipping_to_name,email)VALUES
		(@DRID,-1,'','','','','','','')
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
