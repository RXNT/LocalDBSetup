ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v7_NQF0033_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v7_NQF0033_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v7_NQF0033_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
