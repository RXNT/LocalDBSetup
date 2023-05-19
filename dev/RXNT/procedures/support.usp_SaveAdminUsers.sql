SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 24-OCT-2018
-- Description:	Save Admin Users
-- Modified By: 
-- Modified Date: 
-- =============================================


CREATE PROCEDURE [support].[usp_SaveAdminUsers] --'PDC','PDC','Apex@007','PDC','Admin',8196
( 
	@AdminCompanyName VARCHAR(50),
	@Username	VARCHAR(50),
	@Password	VARCHAR(50),
	@Firstname	VARCHAR(50),
	@Lastname	VARCHAR(50),
	@AdminUserRights BIGINT
)
AS
BEGIN
    DECLARE @AdminCompanyId AS INT

	

	SELECT @AdminCompanyId = admin_company_id FROM admin_companies WHERE admin_company_name = @AdminCompanyName

	IF @AdminCompanyId IS NULL
    BEGIN
       INSERT INTO admin_companies (admin_company_name,admin_company_rights) VALUES (@AdminCompanyName,221184)
       SELECT @AdminCompanyId = SCOPE_IDENTITY()
    END
	--SELECT @AdminCompanyId
	IF NOT EXISTS(SELECT TOP 1 1 FROM admin_users  WITH(NOLOCK)  WHERE admin_username = @Username )
	BEGIN
		INSERT INTO admin_users (admin_company_id,admin_username,admin_password,admin_first_name,admin_last_name,admin_user_rights,admin_user_create_date)
 VALUES(@AdminCompanyId,@Username,@Password,@Firstname,@Lastname,@AdminUserRights,GETDATE())
	END
	ELSE
	BEGIN 
		PRINT 'UserName Already Exist'
	END
		
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
