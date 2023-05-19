CREATE USER [skesarkar] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER skesarkar*/ exec sp_addrolemember 'db_owner', 'skesarkar'
GO
