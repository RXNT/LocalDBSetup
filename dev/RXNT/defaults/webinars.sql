ALTER TABLE [dbo].[webinars] ADD CONSTRAINT [DF__webinars__meetin__6D849645] DEFAULT ('') FOR [meetingURL]
GO
ALTER TABLE [dbo].[webinars] ADD CONSTRAINT [DF_webinars_activeFlag] DEFAULT ((1)) FOR [activeFlag]
GO
ALTER TABLE [dbo].[webinars] ADD CONSTRAINT [DF__webinars__eventt__790135E9] DEFAULT ((1)) FOR [eventtype_id]
GO
