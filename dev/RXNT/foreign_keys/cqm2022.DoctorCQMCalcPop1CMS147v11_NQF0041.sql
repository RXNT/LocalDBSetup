ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v11_NQF0041_DoctorCQMCalcPop1CMS147v11_NQF00412]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v11_NQF0041_DoctorCQMCalculationRequest]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v11_NQF0041_DoctorCQMCalcPop1CMS147v11_NQF00411]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
