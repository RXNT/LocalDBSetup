ALTER TABLE [dbo].[DoctorIssues] ADD CONSTRAINT [DF__doctoriss__Conta__4420F751] DEFAULT ('') FOR [ContactName]
GO
ALTER TABLE [dbo].[DoctorIssues] ADD CONSTRAINT [DF__doctoriss__Conta__45151B8A] DEFAULT ('') FOR [Contact]
GO
ALTER TABLE [dbo].[DoctorIssues] ADD CONSTRAINT [DF__DoctorIss__resol__46093FC3] DEFAULT ((0)) FOR [resolution_status]
GO
ALTER TABLE [dbo].[DoctorIssues] ADD CONSTRAINT [DF__DoctorIss__Respo__628582E0] DEFAULT ('') FOR [Response]
GO
