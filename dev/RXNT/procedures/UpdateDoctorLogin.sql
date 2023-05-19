SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE UpdateDoctorLogin
	(@drId AS BIGINT,@userId AS VARCHAR(150),@newUserId AS VARCHAR(150))
AS
BEGIN
	IF EXISTS(SELECT DR_ID FROM DOCTORS WHERE DR_USERNAME=@newUserId)
		BEGIN
			 RAISERROR ('Log-in ID already exists. Please choose new log-in ID', 16,1 );
		END
	ELSE
		BEGIN
			UPDATE DOCTORS SET DR_USERNAME=@newUserId WHERE DR_USERNAME=@userId AND DR_ID=@drId
		END	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
