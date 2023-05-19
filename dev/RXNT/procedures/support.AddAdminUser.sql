SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE  [support].[AddAdminUser]  -- Partner and Admin 
@PartnerName As Varchar(100),
@DCID As Integer,
@AdminUserName AS VARCHAR(100), 
@AdminUserPassword AS VARCHAR(20),
@AdminFirstName AS VARCHAR(20),
@AdminLastName AS VARCHAR(20),
@AdminRights As integer = 221184

AS
DECLARE @PartnerId As Integer = 0
DECLARE @AdminCompanyID As Integer = 0
DECLARE @AdminUserID As Integer = 0
BEGIN
	If @PartnerName = '' Or @DCID = 0  ---- New RxNT Admin User
	Begin
		select @AdminUserID = IsNull(admin_id,0) from 
			admin_users with(nolock) where admin_username like @AdminUserName 
		If @AdminUserID < 1
		Begin
			insert into admin_users
		(admin_company_id,admin_username,admin_password,admin_first_name,admin_middle_initial,
			admin_last_name,enabled,admin_user_rights,admin_user_create_date,sales_person_id,
				tracker_pwd,tracker_uid,is_token)
			values(1,@AdminUserName,@AdminUserPassword,
				@AdminFirstName,'',@AdminLastName,1,-1,getdate(),0,'','',0)
		End
	End
	Else
	Begin
		select @PartnerId=IsNULL(partner_id,0) from partner_accounts with(nolock) where PARTNER_NAME like @PartnerName
	
		select @AdminCompanyID = admin_company_id from admin_companies with(nolock) 
		where admin_company_name like @PartnerName

		If NOT EXISTS (select admin_company_id from admin_companies with(nolock) 
		where admin_company_name = @PartnerName) --CREATE THE ADMIN_COMPANY_ID
		BEGIN
			--PRINT 'BEFORE INSERT'
			INSERT into admin_companies(admin_company_name,admin_company_rights,enabled)
				values(@PartnerName,@AdminRights,1)
			select @AdminCompanyID = IsNull(admin_company_id,0) from admin_companies with(nolock) where admin_company_name like @PartnerName 
		END

		If @PartnerId > 1 And @AdminCompanyID > 1 -- Validate Identifiers
	Begin
		-- Create Admin user account
		select @AdminUserID = IsNull(admin_id,0) from admin_users with(nolock) where admin_username like @AdminUserName 
		If @AdminUserID < 1
		Begin
			insert into admin_users
			(admin_company_id,admin_username,admin_password,admin_first_name,admin_middle_initial,
				admin_last_name,enabled,admin_user_rights,admin_user_create_date,sales_person_id,
				tracker_pwd,tracker_uid,is_token)
			values(@AdminCompanyID,@AdminUserName,@AdminUserPassword,
				@AdminFirstName,'',@AdminLastName,1,-1,getdate(),0,'','',0)
		End
		Update doc_companies set admin_company_id=@AdminCompanyID where dc_id=@DCID

		update partner_accounts set admin_company_id=@AdminCompanyID where partner_id=@PartnerId
	End
	Else -- Validate Identifiers
		BEGIN
			PRINT 'Either  admin or partner account not created, please check before retrying'
		END
	End
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
