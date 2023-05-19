CREATE USER [val] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER val*/ exec sp_addrolemember 'db_owner', 'val'
GO
