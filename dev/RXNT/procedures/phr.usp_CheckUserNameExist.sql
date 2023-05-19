SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	25-OCT-2017
Description			:	This procedure is used to Check Username Exist
Last Modified By	:   Ayja Weems
Last Modifed Date	:   13-Feb-2023
Last Modification   :   Check for active logins w/ matching username
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_CheckUserNameExist]	
	-- Add the parameters for the stored procedure here
	@UserName VARCHAR(100),
	@PatientId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Count as int
	-- To check if patient already has login enabled
	Declare @LoginCount as int
	SELECT @Count=COUNT(1)
	from dbo.patient_login
    where pa_username = @UserName
    AND enabled = 1
	
    SELECT @LoginCount =COUNT(1)
	from dbo.patient_login where pa_id = @PatientId AND enabled = 1
	
    Select @Count as UsernameCount , @LoginCount as LoginCount	

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
