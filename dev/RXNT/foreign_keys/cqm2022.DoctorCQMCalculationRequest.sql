ALTER TABLE [cqm2022].[DoctorCQMCalculationRequest] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalculationRequest_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
