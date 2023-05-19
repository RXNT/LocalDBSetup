ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS117v7_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v7_NQF0038_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS117v7_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v7_NQF0038_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS117v7_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v7_NQF0038_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
