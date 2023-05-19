CREATE USER [lian] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER lian*/ exec sp_addrolemember 'db_owner', 'lian'
GO
