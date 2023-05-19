CREATE USER [jerreck] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER jerreck*/ exec sp_addrolemember 'db_owner', 'jerreck'
GO
