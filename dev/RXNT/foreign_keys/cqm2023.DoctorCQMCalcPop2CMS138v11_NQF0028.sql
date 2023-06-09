ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS138v11_NQF0028_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS138v11_NQF0028_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS138v11_NQF0028_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
