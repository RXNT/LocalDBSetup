ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS69v11_NQF0421] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS69v11_NQF0421_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS69v11_NQF0421] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS69v11_NQF0421_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS69v11_NQF0421] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS69v11_NQF0421_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
