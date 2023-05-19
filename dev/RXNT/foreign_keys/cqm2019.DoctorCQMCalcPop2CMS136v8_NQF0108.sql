ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v8_NQF0108_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v8_NQF0108_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v8_NQF0108_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO