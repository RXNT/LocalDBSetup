IF SUSER_ID('cbutterworth') IS NULL
				BEGIN CREATE LOGIN cbutterworth WITH PASSWORD = 0x02003F4CA76189B0BDB0B5C8E09E879D855D54484A424F5A15E53B896C2A65189A05CA1090BDB5B17E3327966997BE35D39DC36DE4519878AF509B0882C925B028983AE14720 HASHED END
CREATE USER [cbutterworth] FOR LOGIN [cbutterworth] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER cbutterworth*/ exec sp_addrolemember 'db_datareader', 'cbutterworth'
/*ALTER ROLE db_datawriter ADD MEMBER cbutterworth*/ exec sp_addrolemember 'db_datawriter', 'cbutterworth'
GO
