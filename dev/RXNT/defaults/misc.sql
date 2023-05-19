ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_db_ver] DEFAULT (256) FOR [db_ver]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_city_ver] DEFAULT (0) FOR [city_ver]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_app_ver] DEFAULT ('') FOR [app_ver]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_url] DEFAULT ('') FOR [url]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_file] DEFAULT ('') FOR [fileName]
GO
