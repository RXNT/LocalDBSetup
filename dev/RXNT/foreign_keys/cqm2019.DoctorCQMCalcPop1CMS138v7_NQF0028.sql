ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v7_NQF0028_DoctorCQMCalcPop1CMS138v7_NQF00282]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v7_NQF0028_DoctorCQMCalcPop1CMS138v7_NQF00281]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v7_NQF0028_DoctorCQMCalcPop1CMS138v7_NQF0028]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
