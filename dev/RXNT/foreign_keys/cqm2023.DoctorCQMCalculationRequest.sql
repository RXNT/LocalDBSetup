ALTER TABLE [cqm2023].[DoctorCQMCalculationRequest] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalculationRequest_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalculationRequest] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalculationRequest_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
