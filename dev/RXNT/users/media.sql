IF SUSER_ID('media') IS NULL
				BEGIN CREATE LOGIN media WITH PASSWORD = 0x020077FE21105E4BBAF4FE789ADE4F62533E593A72902C3CF1A86CDF50FDC52A8DE62D43EA5D4936EBD925996A63BB4B4ED86B13B5061094E579A21FA93603E001F8FC92FBE8 HASHED END
CREATE USER [media] FOR LOGIN [media] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER media*/ exec sp_addrolemember 'db_owner', 'media'
GO