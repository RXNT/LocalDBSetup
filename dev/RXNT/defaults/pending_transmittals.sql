ALTER TABLE [dbo].[pending_transmittals] ADD CONSTRAINT [DF_pending_transmittals_pending_ack] DEFAULT ((0)) FOR [pending_ack]
GO
ALTER TABLE [dbo].[pending_transmittals] ADD CONSTRAINT [DF_pending_transmittals_pres_delivery_method] DEFAULT ((1)) FOR [pres_delivery_method]
GO
