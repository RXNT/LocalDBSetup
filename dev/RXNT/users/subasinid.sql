CREATE USER [subasinid] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER subasinid*/ exec sp_addrolemember 'db_owner', 'subasinid'
GO
