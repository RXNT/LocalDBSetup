CREATE USER [kleber-toptal] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER kleber-toptal*/ exec sp_addrolemember 'db_datareader', 'kleber-toptal'
GO
