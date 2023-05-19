ALTER TABLE [dbo].[MichiganTargetPhysicians] ADD CONSTRAINT [DF_MichiganTargetPhysicians_faxed] DEFAULT ((0)) FOR [faxed]
GO
ALTER TABLE [dbo].[MichiganTargetPhysicians] ADD CONSTRAINT [DF_MichiganTargetPhysicians_not_interested] DEFAULT ((0)) FOR [not_interested]
GO
