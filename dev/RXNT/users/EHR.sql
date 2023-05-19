CREATE USER [EHR] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER EHR*/ exec sp_addrolemember 'db_executor', 'EHR'
/*ALTER ROLE db_datareader ADD MEMBER EHR*/ exec sp_addrolemember 'db_datareader', 'EHR'
/*ALTER ROLE db_datawriter ADD MEMBER EHR*/ exec sp_addrolemember 'db_datawriter', 'EHR'
GO
