SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE ValidateDoctorLogin 
	(@dr_id AS BIGINT,
	 @dr_Login AS VARCHAR(200),
	 @isValid AS BIT OUTPUT)
AS
BEGIN
	IF EXISTS(SELECT a.dctr_id FROM 
			 (SELECT MIN(dr_id) AS dctr_id FROM DOCTORS WHERE DR_USERNAME= @dr_Login) a
			 INNER JOIN doctors dr on dr.dr_id=a.dctr_id
		     INNER JOIN doctor_info d ON d.dr_id =@dr_id
			 WHERE  a.dctr_id < @dr_id AND d.bDuplicateUser=1 AND dr.dr_enabled=1)
		BEGIN
			SET @isValid=0
		END
	ELSE
		BEGIN
			SET @isValid=1
		END		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
