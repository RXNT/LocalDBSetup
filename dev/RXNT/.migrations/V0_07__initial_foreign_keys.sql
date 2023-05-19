ALTER TABLE [adm].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [aut].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_aut_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [aut].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_aut_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS117v7_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v7_NQF0038_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS117v7_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v7_NQF0038_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS117v7_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v7_NQF0038_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS136v8_NQF0108_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS136v8_NQF0108_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS136v8_NQF0108_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v7_NQF0028_DoctorCQMCalcPop1CMS138v7_NQF00282]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v7_NQF0028_DoctorCQMCalcPop1CMS138v7_NQF00281]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v7_NQF0028_DoctorCQMCalcPop1CMS138v7_NQF0028]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS147v8_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v8_NQF0041_DoctorCQMCalcPop1CMS147v8_NQF00412]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS147v8_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v8_NQF0041_DoctorCQMCalculationRequest]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS147v8_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v8_NQF0041_DoctorCQMCalcPop1CMS147v8_NQF00411]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v7_NQF0033_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v7_NQF0033_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v7_NQF0033_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS155v7_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS155v7_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS155v7_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS68v8_NQF0419] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS68v8_NQF0419_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS68v8_NQF0419] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS68v8_NQF0419_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS68v8_NQF0419] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS68v8_NQF0419_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS69v7_NQF0421] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS69v7_NQF0421_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS69v7_NQF0421] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS69v7_NQF0421_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop1CMS69v7_NQF0421] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS69v7_NQF0421_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v8_NQF0108_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v8_NQF0108_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS136v8_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v8_NQF0108_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS138v7_NQF0028_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS138v7_NQF0028_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS138v7_NQF0028_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS155v7_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS155v7_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop2CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS155v7_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop3CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS138v7_NQF0028_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop3CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS138v7_NQF0028_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop3CMS138v7_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS138v7_NQF0028_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop3CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS155v7_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop3CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS155v7_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalcPop3CMS155v7_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS155v7_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2019].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2019].[DoctorCQMCalculationRequest] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalculationRequest_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_PatientAttributeCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_PatientAttributeCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_PatientAttributeCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosisCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosisCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosisCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosticStudyCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosticStudyCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosticStudyCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_PatientEncounterCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_PatientEncounterCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientImmunizationCodes_PatientImmunizationCodes2]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientImmunizationCodes_PatientImmunizationCodes1]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientImmunizationCodes_PatientImmunizationCodes]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientInterventionCodes] WITH CHECK ADD CONSTRAINT [FK_PatientInterventionCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientInterventionCodes] WITH CHECK ADD CONSTRAINT [FK_PatientInterventionCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientMedicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientMedicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationProcedureCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationProcedureCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationProcedureCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientProcedureCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientProcedureCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2019].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_PatientRiskCategoryOrAssessmentCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_PatientRiskCategoryOrAssessmentCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2019].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_PatientRiskCategoryOrAssessmentCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS117v10_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v10_NQF0038_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS117v10_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v10_NQF0038_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS117v10_NQF0038] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS117v10_NQF0038_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS136v11_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS136v11_NQF0108_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS136v11_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS136v11_NQF0108_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS136v11_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS136v11_NQF0108_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v10_NQF0028_DoctorCQMCalcPop1CMS138v10_NQF00282]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v10_NQF0028_DoctorCQMCalcPop1CMS138v10_NQF00281]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS138v10_NQF0028_DoctorCQMCalcPop1CMS138v10_NQF0028]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v11_NQF0041_DoctorCQMCalcPop1CMS147v11_NQF00412]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v11_NQF0041_DoctorCQMCalculationRequest]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS147v11_NQF0041_DoctorCQMCalcPop1CMS147v11_NQF00411]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS153v10_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v10_NQF0033_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS153v10_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v10_NQF0033_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS153v10_NQF0033] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS153v10_NQF0033_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS155v10_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS155v10_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS155v10_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS68v11_NQF0419] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS68v11_NQF0419_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS68v11_NQF0419] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS68v11_NQF0419_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS68v11_NQF0419] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS68v11_NQF0419_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS69v10_NQF0421] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS69v10_NQF0421_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS69v10_NQF0421] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS69v10_NQF0421_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop1CMS69v10_NQF0421] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop1CMS69v10_NQF0421_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS136v11_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v11_NQF0108_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS136v11_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v11_NQF0108_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS136v11_NQF0108] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS136v11_NQF0108_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS138v10_NQF0028_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS138v10_NQF0028_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS138v10_NQF0028_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS155v10_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS155v10_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop2CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop2CMS155v10_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop3CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS138v10_NQF0028_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop3CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS138v10_NQF0028_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop3CMS138v10_NQF0028] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS138v10_NQF0028_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop3CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS155v10_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop3CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS155v10_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalcPop3CMS155v10_NQF0024] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalcPop3CMS155v10_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2022].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2022].[DoctorCQMCalculationRequest] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalculationRequest_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_PatientAttributeCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_PatientAttributeCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_PatientAttributeCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosisCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosisCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosisCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosticStudyCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosticStudyCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_PatientDiagnosticStudyCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_PatientEncounterCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_PatientEncounterCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientImmunizationCodes_PatientImmunizationCodes2]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientImmunizationCodes_PatientImmunizationCodes1]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientImmunizationCodes_PatientImmunizationCodes]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientInterventionCodes] WITH CHECK ADD CONSTRAINT [FK_PatientInterventionCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientInterventionCodes] WITH CHECK ADD CONSTRAINT [FK_PatientInterventionCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientMedicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientMedicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationProcedureCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationProcedureCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientMedicationProcedureCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientProcedureCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_PatientProcedureCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2022].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_PatientRiskCategoryOrAssessmentCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_PatientRiskCategoryOrAssessmentCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_PatientRiskCategoryOrAssessmentCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS117v11_NQF0038] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS117v11_NQF0038_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS117v11_NQF0038] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS117v11_NQF0038_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS117v11_NQF0038] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS117v11_NQF0038_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS136v12_NQF0108] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS136v12_NQF0108_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS136v12_NQF0108] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS136v12_NQF0108_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS136v12_NQF0108] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS136v12_NQF0108_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS138v11_NQF0028_DoctorCQMCalcPop1CMS138v11_NQF00282]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS138v11_NQF0028_DoctorCQMCalcPop1CMS138v11_NQF00281]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS138v11_NQF0028_DoctorCQMCalcPop1CMS138v11_NQF0028]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS147v12_NQF0041] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS147v12_NQF0041_DoctorCQMCalcPop1CMS147v12_NQF00412]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS147v12_NQF0041] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS147v12_NQF0041_DoctorCQMCalculationRequest]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS147v12_NQF0041] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS147v12_NQF0041_DoctorCQMCalcPop1CMS147v12_NQF00411]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS153v11_NQF0033] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS153v11_NQF0033_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS153v11_NQF0033] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS153v11_NQF0033_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS153v11_NQF0033] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS153v11_NQF0033_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS155v11_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS155v11_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS155v11_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS68v12_NQF0419] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS68v12_NQF0419_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS68v12_NQF0419] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS68v12_NQF0419_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS68v12_NQF0419] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS68v12_NQF0419_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS69v11_NQF0421] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS69v11_NQF0421_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS69v11_NQF0421] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS69v11_NQF0421_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop1CMS69v11_NQF0421] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop1CMS69v11_NQF0421_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS136v12_NQF0108] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS136v12_NQF0108_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS136v12_NQF0108] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS136v12_NQF0108_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS136v12_NQF0108] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS136v12_NQF0108_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS138v11_NQF0028_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS138v11_NQF0028_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS138v11_NQF0028_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS155v11_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS155v11_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop2CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop2CMS155v11_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop3CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop3CMS138v11_NQF0028_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop3CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop3CMS138v11_NQF0028_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop3CMS138v11_NQF0028] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop3CMS138v11_NQF0028_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop3CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop3CMS155v11_NQF0024_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop3CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop3CMS155v11_NQF0024_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalcPop3CMS155v11_NQF0024] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalcPop3CMS155v11_NQF0024_DoctorCQMCalculationRequest]
   FOREIGN KEY([RequestId]) REFERENCES [cqm2023].[DoctorCQMCalculationRequest] ([RequestId])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalculationRequest] WITH CHECK ADD CONSTRAINT [FK_DoctorCQMCalculationRequest_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[DoctorCQMCalculationRequest] WITH CHECK ADD CONSTRAINT [FK_cqm2023_DoctorCQMCalculationRequest_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientAttributeCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientAttributeCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientAttributeCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientAttributeCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientCommunicationCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientCommunicationCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientCommunicationCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientDiagnosisCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientDiagnosisCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientDiagnosisCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientDiagnosisCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientDiagnosticStudyCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientDiagnosticStudyCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientDiagnosticStudyCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientDiagnosticStudyCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientEncounterCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientEncounterCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientImmunizationCodes_PatientImmunizationCodes2]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientImmunizationCodes_PatientImmunizationCodes1]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientImmunizationCodes_PatientImmunizationCodes]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientInterventionCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientInterventionCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientInterventionCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientInterventionCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientLaboratoryTestCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientLaboratoryTestCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientLaboratoryTestCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientMedicationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientMedicationCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientMedicationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientMedicationCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientMedicationProcedureCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientMedicationProcedureCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientMedicationProcedureCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientPhysicalExamCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientPhysicalExamCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientPhysicalExamCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientProcedureCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientProcedureCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [cqm2023].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientRiskCategoryOrAssessmentCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientRiskCategoryOrAssessmentCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientRiskCategoryOrAssessmentCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientRiskCategoryOrAssessmentCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [dbo].[DataExportSettings] WITH CHECK ADD CONSTRAINT [FK_DataExportSettings_DoctorCompanies]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [dbo].[doctor_grouping_details] WITH CHECK ADD CONSTRAINT [FK_doctor_grouping_details_doctor_grouping]
   FOREIGN KEY([grp_id]) REFERENCES [dbo].[doctor_grouping] ([grp_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[doctor_patient_messages] WITH CHECK ADD CONSTRAINT [FK_doctor_patient_messages_PatientRepresentatives]
   FOREIGN KEY([PatientRepresentativeId]) REFERENCES [phr].[PatientRepresentatives] ([PatientRepresentativeId])

GO
ALTER TABLE [dbo].[doc_company_themes] WITH CHECK ADD CONSTRAINT [FK_doc_company_themes_doc_company_themes_xref]
   FOREIGN KEY([theme_id]) REFERENCES [dbo].[doc_company_themes_xref] ([theme_id])

GO
ALTER TABLE [dbo].[doc_fav_scripts] WITH CHECK ADD CONSTRAINT [FK_doc_fav_scripts_hospice_drug_relatedness]
   FOREIGN KEY([hospice_drug_relatedness_id]) REFERENCES [dbo].[hospice_drug_relatedness] ([hospice_drug_relatedness_id])

GO
ALTER TABLE [dbo].[doc_fav_scripts_sig_details] WITH CHECK ADD CONSTRAINT [FK_doc_fav_scripts_sig_details_doc_fav_scripts]
   FOREIGN KEY([script_id]) REFERENCES [dbo].[doc_fav_scripts] ([script_id])

GO
ALTER TABLE [dbo].[doc_fav_scripts_sig_details] WITH CHECK ADD CONSTRAINT [FK_doc_fav_scripts_sig_details_doc_fav_scripts_sig_details]
   FOREIGN KEY([script_sig_id]) REFERENCES [dbo].[doc_fav_scripts_sig_details] ([script_sig_id])

GO
ALTER TABLE [dbo].[doc_fav_vitals] WITH CHECK ADD CONSTRAINT [fk_favVitals1]
   FOREIGN KEY([vitalsId]) REFERENCES [dbo].[doc_vitalsList] ([vitalsId])

GO
ALTER TABLE [dbo].[doc_group_fav_scripts] WITH CHECK ADD CONSTRAINT [FK_doc_group_fav_scripts_hospice_drug_relatedness]
   FOREIGN KEY([hospice_drug_relatedness_id]) REFERENCES [dbo].[hospice_drug_relatedness] ([hospice_drug_relatedness_id])

GO
ALTER TABLE [dbo].[doc_group_fav_scripts_sig_details] WITH CHECK ADD CONSTRAINT [FK_doc_group_fav_scripts_sig_details_doc_group_fav_scripts]
   FOREIGN KEY([script_id]) REFERENCES [dbo].[doc_group_fav_scripts] ([script_id])

GO
ALTER TABLE [dbo].[doc_group_module_info] WITH CHECK ADD CONSTRAINT [FK_doc_group_module_info_doc_group_module_info]
   FOREIGN KEY([dg_module_info_id]) REFERENCES [dbo].[doc_group_module_info] ([dg_module_info_id])

GO
ALTER TABLE [dbo].[doc_group_page_module_info] WITH CHECK ADD CONSTRAINT [FK_doc_group_page_module_info_doc_group_module_info]
   FOREIGN KEY([dg_module_info_id]) REFERENCES [dbo].[doc_group_module_info] ([dg_module_info_id])

GO
ALTER TABLE [dbo].[doc_group_page_module_info] WITH CHECK ADD CONSTRAINT [FK_doc_group_page_module_info_doc_group_page_info]
   FOREIGN KEY([dg_page_info_id]) REFERENCES [dbo].[doc_group_page_info] ([dg_page_info_id])

GO
ALTER TABLE [ehr].[ApplicationConfiguration] WITH CHECK ADD CONSTRAINT [FK_ApplicationConfiguration_ConfigurationDataType]
   FOREIGN KEY([ConfigurationDataTypeId]) REFERENCES [ehr].[ApplicationTableConstants] ([ApplicationTableConstantId])

GO
ALTER TABLE [ehr].[ApplicationConfiguration] WITH CHECK ADD CONSTRAINT [FK_ApplicationConfiguration_ConfigurationValue]
   FOREIGN KEY([ConfigurationValueId]) REFERENCES [ehr].[ApplicationTableConstants] ([ApplicationTableConstantId])

GO
ALTER TABLE [ehr].[ApplicationTableConstants] WITH CHECK ADD CONSTRAINT [FK_ApplicationTableConstants_ApplicationTables]
   FOREIGN KEY([ApplicationTableId]) REFERENCES [ehr].[ApplicationTables] ([ApplicationTableId])

GO
ALTER TABLE [ehr].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_ehr_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [ehr].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_ehr_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [ehr].[CompanyApplicationConfiguration] WITH CHECK ADD CONSTRAINT [FK_CompanyApplicationConfiguration_ApplicationConfigurationId]
   FOREIGN KEY([ApplicationConfigurationId]) REFERENCES [ehr].[ApplicationConfiguration] ([ApplicationConfigurationId])

GO
ALTER TABLE [ehr].[CompanyApplicationConfiguration] WITH CHECK ADD CONSTRAINT [FK_CompanyApplicationConfiguration_ConfigurationValue]
   FOREIGN KEY([ConfigurationValueId]) REFERENCES [ehr].[ApplicationTableConstants] ([ApplicationTableConstantId])

GO
ALTER TABLE [enc].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_enc_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [enc].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_enc_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [dbo].[enchanced_encounter] WITH CHECK ADD CONSTRAINT [FK_enchanced_encounter_EncounterNoteType]
   FOREIGN KEY([EncounterNoteTypeId]) REFERENCES [enc].[EncounterNoteType] ([Id])

GO
ALTER TABLE [dbo].[enchanced_encounter] WITH CHECK ADD CONSTRAINT [FkEnchancedEncounterInformationBlockingReason]
   FOREIGN KEY([InformationBlockingReasonId]) REFERENCES [dbo].[InformationBlockingReason] ([Id])

GO
ALTER TABLE [epa].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_epa_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [epa].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_epa_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [epa].[epa_token_log] WITH CHECK ADD CONSTRAINT [FK_epa_token_log_doc_companies]
   FOREIGN KEY([dc_id]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [epa].[epa_transaction_log] WITH CHECK ADD CONSTRAINT [FK_epa_transaction_log_doc_companies]
   FOREIGN KEY([dc_id]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [epa].[epa_transaction_log] WITH CHECK ADD CONSTRAINT [FK_epa_transaction_log_patient_id]
   FOREIGN KEY([pa_id]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [ext].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_ext_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [ext].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_ext_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [dbo].[FreeSample_Breeze2_ids] WITH CHECK ADD CONSTRAINT [FK_FreeSample_Breeze2_ids_FreeSample]
   FOREIGN KEY([SampleIdXref]) REFERENCES [dbo].[FreeSample] ([SampleId])

GO
ALTER TABLE [dbo].[lab_embedded_data] WITH CHECK ADD CONSTRAINT [FK_lab_embedded_data_lab_result_details]
   FOREIGN KEY([lab_result_id]) REFERENCES [dbo].[lab_result_details] ([lab_result_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[lab_main] WITH CHECK ADD CONSTRAINT [FKLabMainInformationBlockingReason]
   FOREIGN KEY([InformationBlockingReasonId]) REFERENCES [dbo].[InformationBlockingReason] ([Id])

GO
ALTER TABLE [dbo].[lab_order_info] WITH CHECK ADD CONSTRAINT [FK_lab_order_info_lab_main]
   FOREIGN KEY([lab_id]) REFERENCES [dbo].[lab_main] ([lab_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[lab_pat_details] WITH CHECK ADD CONSTRAINT [FK_lab_pat_details_lab_main]
   FOREIGN KEY([lab_id]) REFERENCES [dbo].[lab_main] ([lab_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[lab_result_details] WITH CHECK ADD CONSTRAINT [FK_lab_result_details_lab_result_info]
   FOREIGN KEY([lab_result_info_id]) REFERENCES [dbo].[lab_result_info] ([lab_result_info_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[lab_result_info] WITH CHECK ADD CONSTRAINT [FK_lab_result_info_lab_main]
   FOREIGN KEY([lab_id]) REFERENCES [dbo].[lab_main] ([lab_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[lab_result_info] WITH CHECK ADD CONSTRAINT [FK_lab_result_info_lab_order_info]
   FOREIGN KEY([lab_order_id]) REFERENCES [dbo].[lab_order_info] ([lab_report_id])

GO
ALTER TABLE [dbo].[lab_result_place_srv] WITH CHECK ADD CONSTRAINT [FK_lab_result_place_srv_lab_result_info]
   FOREIGN KEY([lab_result_info_id]) REFERENCES [dbo].[lab_result_info] ([lab_result_info_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[lab_result_specimen] WITH CHECK ADD CONSTRAINT [FK__lab_resul__lab_i__5C39435B]
   FOREIGN KEY([lab_id]) REFERENCES [dbo].[lab_main] ([lab_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [mda].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_mda_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [mda].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_mda_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [dbo].[PatientCarePlan] WITH CHECK ADD CONSTRAINT [FK_PatientCarePlan_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [dbo].[PatientCarePlan] WITH CHECK ADD CONSTRAINT [FK_PatientCarePlan_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [dbo].[PatientCareTeamMember] WITH CHECK ADD CONSTRAINT [FK_PatientCareTeamMember_PatientId]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [dbo].[PatientCareTeamMember] WITH CHECK ADD CONSTRAINT [FK_PatientCareTeamMember_StatusId]
   FOREIGN KEY([StatusId]) REFERENCES [dbo].[PatientCareTeamMemberStatus] ([Id])

GO
ALTER TABLE [dbo].[PatientGoals] WITH CHECK ADD CONSTRAINT [FK_PatientGoals_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [dbo].[PatientGoals] WITH CHECK ADD CONSTRAINT [FK_PatientGoals_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [dbo].[PatientHealthConcerns] WITH CHECK ADD CONSTRAINT [FK_PatientHealthConcerns_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [dbo].[PatientHealthConcerns] WITH CHECK ADD CONSTRAINT [FK_PatientHealthConcerns_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [dbo].[patients] WITH CHECK ADD CONSTRAINT [FkPatientsInformationBlockingReason]
   FOREIGN KEY([InformationBlockingReasonId]) REFERENCES [dbo].[InformationBlockingReason] ([Id])

GO
ALTER TABLE [dbo].[PatientTokens] WITH CHECK ADD CONSTRAINT [FK_PatientTokens_Companies]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [dbo].[patient_assessment] WITH CHECK ADD CONSTRAINT [FK_patient_assessment_patient_encounters]
   FOREIGN KEY([enc_id]) REFERENCES [dbo].[patient_encounters] ([enc_id])

GO
ALTER TABLE [dbo].[Patient_CCD_request_queue] WITH CHECK ADD CONSTRAINT [FK_Patient_CCD_request_queue_Patient_CCD_request_batch]
   FOREIGN KEY([batchid]) REFERENCES [dbo].[Patient_CCD_request_batch] ([batchid])

GO
ALTER TABLE [dbo].[Patient_Encounter_request_queue] WITH CHECK ADD CONSTRAINT [FK_Patient_Encounter_request_queue_Patient_Encounter_request_batch]
   FOREIGN KEY([batchid]) REFERENCES [dbo].[Patient_Encounter_request_batch] ([batchid])

GO
ALTER TABLE [dbo].[patient_enc_plan_of_care] WITH CHECK ADD CONSTRAINT [FK_patient_enc_plan_of_care_patient_encounters]
   FOREIGN KEY([enc_id]) REFERENCES [dbo].[patient_encounters] ([enc_id])

GO
ALTER TABLE [dbo].[patient_hpi] WITH CHECK ADD CONSTRAINT [FK_patient_hpi_patient_hpi]
   FOREIGN KEY([enc_id]) REFERENCES [dbo].[patient_encounters] ([enc_id])

GO
ALTER TABLE [dbo].[patient_menu_doctor_level] WITH CHECK ADD CONSTRAINT [FK_patient_menu_doctor_level_doc_companies]
   FOREIGN KEY([dc_id]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [dbo].[patient_menu_doctor_level] WITH CHECK ADD CONSTRAINT [FK_patient_menu_doctor_level_master_patient_menu]
   FOREIGN KEY([master_patient_menu_id]) REFERENCES [dbo].[master_patient_menu] ([master_patient_menu_id])

GO
ALTER TABLE [dbo].[Patient_merge_request_queue] WITH CHECK ADD CONSTRAINT [FK_Patient_merge_request_queue_Patient_merge_request_batch]
   FOREIGN KEY([pa_merge_batchid]) REFERENCES [dbo].[Patient_merge_request_batch] ([pa_merge_batchid])

GO
ALTER TABLE [dbo].[Patient_merge_transaction] WITH CHECK ADD CONSTRAINT [FK_Patient_merge_transaction_Patient_merge_request_queue]
   FOREIGN KEY([pa_merge_reqid]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [dbo].[patient_phr_access_log] WITH CHECK ADD CONSTRAINT [FK_patient_phr_access_log_PatientRepresentatives]
   FOREIGN KEY([PatientRepresentativeId]) REFERENCES [phr].[PatientRepresentatives] ([PatientRepresentativeId])

GO
ALTER TABLE [dbo].[patient_review_of_sys] WITH CHECK ADD CONSTRAINT [FK_review_of_sys_patient_encounters]
   FOREIGN KEY([enc_id]) REFERENCES [dbo].[patient_encounters] ([enc_id])

GO
ALTER TABLE [phr].[Login] WITH CHECK ADD CONSTRAINT [FK_Login_UserAgreement]
   FOREIGN KEY([UserAgreementId]) REFERENCES [phr].[UserAgreement] ([Id])

GO
ALTER TABLE [phr].[LoginPatientMap] WITH CHECK ADD CONSTRAINT [FK_LoginPatientMap_Login]
   FOREIGN KEY([LoginId]) REFERENCES [phr].[Login] ([Id])

GO
ALTER TABLE [phr].[LoginPatientMap] WITH CHECK ADD CONSTRAINT [FK_LoginPatientMap_PatientId]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [phr].[LoginPatientMap] WITH CHECK ADD CONSTRAINT [FK_LoginPatientMap_Type]
   FOREIGN KEY([Type]) REFERENCES [phr].[LoginType] ([Id])

GO
ALTER TABLE [phr].[LoginToken] WITH CHECK ADD CONSTRAINT [FK_LoginToken_Login]
   FOREIGN KEY([LoginId]) REFERENCES [phr].[Login] ([Id])

GO
ALTER TABLE [phr].[NotificationPreferences] WITH CHECK ADD CONSTRAINT [FK__Notificat__Notif__2662B04F]
   FOREIGN KEY([NotificationId]) REFERENCES [phr].[Notifications] ([NotificationId])

GO
ALTER TABLE [phr].[PatientPortalDocuments] WITH CHECK ADD CONSTRAINT [FK_PatientPortalDocuments_patient_documents]
   FOREIGN KEY([DocumentId]) REFERENCES [dbo].[patient_documents] ([document_id])

GO
ALTER TABLE [phr].[PatientPortalDocuments] WITH CHECK ADD CONSTRAINT [FK_PatientPortalDocuments_PatientRepresentatives]
   FOREIGN KEY([PatientRepresentativeId]) REFERENCES [phr].[PatientRepresentatives] ([PatientRepresentativeId])

GO
ALTER TABLE [phr].[PatientRepresentatives] WITH CHECK ADD CONSTRAINT [FK_PatientRepresentatives_PersonRelationshipId]
   FOREIGN KEY([PersonRelationshipId]) REFERENCES [phr].[PersonRelationships] ([PersonRelationshipId])

GO
ALTER TABLE [phr].[PatientRepresentativesInfo] WITH CHECK ADD CONSTRAINT [FK_PatientRepresentativesInfo_PatientRepresentativeId]
   FOREIGN KEY([PatientRepresentativeId]) REFERENCES [phr].[PatientRepresentatives] ([PatientRepresentativeId])

GO
ALTER TABLE [phr].[PatientTextLog] WITH CHECK ADD CONSTRAINT [FK_PatientTextLog_CreatedByDoctorId]
   FOREIGN KEY([CreatedByDoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [phr].[PatientTextLog] WITH CHECK ADD CONSTRAINT [FK_PatientTextLog_CreatedByPatientId]
   FOREIGN KEY([CreatedByPatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [phr].[PatientTextLog] WITH CHECK ADD CONSTRAINT [FK_PatientTextLog_DoctorCompanyId]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [phr].[PatientTextLog] WITH CHECK ADD CONSTRAINT [FK_PatientTextLog_PatientId]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [phr].[RegistrationWorkflow] WITH CHECK ADD CONSTRAINT [FK_RegistrationWorkflow_DoctorCompanyId]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [phr].[RegistrationWorkflow] WITH CHECK ADD CONSTRAINT [FK_RegistrationWorkflow_DoctorGroupId]
   FOREIGN KEY([DoctorGroupId]) REFERENCES [dbo].[doc_groups] ([dg_id])

GO
ALTER TABLE [phr].[RegistrationWorkflow] WITH CHECK ADD CONSTRAINT [FK_RegistrationWorkflow_PatientId]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [phr].[RegistrationWorkflow] WITH CHECK ADD CONSTRAINT [FK_RegistrationWorkflow_RegistrationWorkflowStateId]
   FOREIGN KEY([RegistrationWorkflowStateId]) REFERENCES [phr].[RegistrationWorkflowState] ([Id])

GO
ALTER TABLE [dbo].[practice_fee_settings] WITH CHECK ADD CONSTRAINT [FK_practice_fee_settings_doc_groups]
   FOREIGN KEY([dg_id]) REFERENCES [dbo].[doc_groups] ([dg_id])

GO
ALTER TABLE [dbo].[prescription_external_info] WITH CHECK ADD CONSTRAINT [FK_prescription_external_info_prescription_details]
   FOREIGN KEY([pd_id]) REFERENCES [dbo].[prescription_details] ([pd_id])

GO
ALTER TABLE [dbo].[prescription_external_info] WITH CHECK ADD CONSTRAINT [FK_prescription_external_info_prescriptions]
   FOREIGN KEY([pres_id]) REFERENCES [dbo].[prescriptions] ([pres_id])

GO
ALTER TABLE [dbo].[prescription_taper_info] WITH CHECK ADD CONSTRAINT [FK_prescription_taper_info_prescription_details]
   FOREIGN KEY([pd_id]) REFERENCES [dbo].[prescription_details] ([pd_id])

GO
ALTER TABLE [dbo].[printer_registration] WITH CHECK ADD CONSTRAINT [FK__printer_r__pm_id__60882BD5]
   FOREIGN KEY([pm_id]) REFERENCES [dbo].[PrinterMaster] ([pm_id])

GO
ALTER TABLE [prv].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_prv_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [prv].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_prv_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [rpt].[DeduplicationExcludePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationExcludePatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationExcludePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationExcludePatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DeduplicationMergePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationMergePatients_DeduplicationPatients]
   FOREIGN KEY([DeduplicationPatientId]) REFERENCES [rpt].[DeduplicationPatients] ([DeduplicationPatientId])

GO
ALTER TABLE [rpt].[DeduplicationMergePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationMergePatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationMergePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationMergePatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DeduplicationPatientGroups] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatientGroups_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationPatientGroups] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatientGroups_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DeduplicationPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatients_DeduplicationPatientGroups]
   FOREIGN KEY([DeduplicationPatientGroupId]) REFERENCES [rpt].[DeduplicationPatientGroups] ([DeduplicationPatientGroupId])

GO
ALTER TABLE [rpt].[DeduplicationPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatients_DuplicationTypes]
   FOREIGN KEY([DuplicationTypeId]) REFERENCES [rpt].[DuplicationTypes] ([DuplicationTypeId])

GO
ALTER TABLE [rpt].[DeduplicationPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatients_Patient_merge_request_queue]
   FOREIGN KEY([PatientMergeRequestBatchId]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatientTransition_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatientTransition_Patient_merge_request_queue]
   FOREIGN KEY([PatientMergeRequestBatchId]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatientTransition_PrimaryPatientCriteriaTypes]
   FOREIGN KEY([PrimaryPatientCriteriaTypeId]) REFERENCES [rpt].[PrimaryPatientCriteriaTypes] ([PrimaryPatientCriteriaTypeId])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatientTransition_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_DeduplicationPrimaryPatients]
   FOREIGN KEY([DeduplicationPrimaryPatientId]) REFERENCES [rpt].[DeduplicationPrimaryPatients] ([DeduplicationPrimaryPatientId])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_DuplicationTypes]
   FOREIGN KEY([DuplicationTypeId]) REFERENCES [rpt].[DuplicationTypes] ([DuplicationTypeId])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_Patient_merge_request_queue]
   FOREIGN KEY([PatientMergeRequestBatchId]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicateRequests] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicateRequests_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationPatientTransition_DoctorCompanyDeduplicationTransition]
   FOREIGN KEY([DoctorCompanyDeduplicationTransitionId]) REFERENCES [rpt].[DoctorCompanyDeduplicationTransition] ([DoctorCompanyDeduplicationTransitionId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationPatientTransition_Patient_merge_request_queue]
   FOREIGN KEY([PatientMergeRequestBatchId]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationPatientTransition_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationTransition_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationTransition_DuplicationTypes]
   FOREIGN KEY([DuplicationTypeId]) REFERENCES [rpt].[DuplicationTypes] ([DuplicationTypeId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationTransition_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [rpt].[ReactivateMergedPrimaryPatientsStatuses] WITH CHECK ADD CONSTRAINT [FK_ReactivateMergedPrimaryPatientsStatuses_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[ReactivateMergedPrimaryPatientsStatuses] WITH CHECK ADD CONSTRAINT [FK_ReactivateMergedPrimaryPatientsStatuses_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
ALTER TABLE [dbo].[scheduler_deletion_log] WITH CHECK ADD CONSTRAINT [FK__scheduler__event__6B9C4DD3]
   FOREIGN KEY([event_id]) REFERENCES [dbo].[scheduler_main] ([event_id])

GO
ALTER TABLE [spe].[SPEMessages] WITH CHECK ADD CONSTRAINT [FK_SPEMessages_prescription_details]
   FOREIGN KEY([pd_id]) REFERENCES [dbo].[prescription_details] ([pd_id])

GO
ALTER TABLE [spe].[SPEMessages] WITH CHECK ADD CONSTRAINT [FK_SPEMessages_prescriptions]
   FOREIGN KEY([pres_id]) REFERENCES [dbo].[prescriptions] ([pres_id])

GO
ALTER TABLE [support].[Patients_Copy_Data_Ref] WITH CHECK ADD CONSTRAINT [FK_Patients_Copy_Data_Ref_CopyRef_Id]
   FOREIGN KEY([CopyRef_Id]) REFERENCES [support].[Patients_Copy_Ref] ([CopyRef_Id])

GO
ALTER TABLE [dbo].[tblPatientExternalVaccinationRequestDetails] WITH CHECK ADD CONSTRAINT [FK__tblPatien__reque__3EA44E34]
   FOREIGN KEY([request_id]) REFERENCES [dbo].[tblPatientExternalVaccinationRequests] ([request_id])

GO
ALTER TABLE [dbo].[tblSubHealthGuidelines] WITH CHECK ADD CONSTRAINT [FK_tblSubHealthGuidelines_tblHealthGuidelines]
   FOREIGN KEY([rule_id]) REFERENCES [dbo].[tblHealthGuidelines] ([rule_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[tblVaccineCVXToVaccineGroupsMappings] WITH CHECK ADD CONSTRAINT [FK_tblVaccineCVXToVaccineGroupsMappings_tblVaccineCVX]
   FOREIGN KEY([cvx_id]) REFERENCES [dbo].[tblVaccineCVX] ([cvx_id])

GO
ALTER TABLE [dbo].[tblVaccineCVXToVISMappings] WITH CHECK ADD CONSTRAINT [FK_tblVaccineCVXToVISMappings_tblVaccineCVX]
   FOREIGN KEY([cvx_id]) REFERENCES [dbo].[tblVaccineCVX] ([cvx_id])

GO
ALTER TABLE [dbo].[tblVaccineCVXToVISMappings] WITH CHECK ADD CONSTRAINT [FK_tblVaccineCVXToVISMappings_tblVaccineVIS]
   FOREIGN KEY([vis_concept_id]) REFERENCES [dbo].[tblVaccineVIS] ([vis_concept_id])

GO
ALTER TABLE [dbo].[tblVaccines] WITH CHECK ADD CONSTRAINT [FK_tblVaccines_tblVaccineCVX]
   FOREIGN KEY([cvx_id]) REFERENCES [dbo].[tblVaccineCVX] ([cvx_id])

GO
ALTER TABLE [dbo].[tblVaccines] WITH CHECK ADD CONSTRAINT [FK_tblVaccines_tblVaccineManufacturers]
   FOREIGN KEY([manufacturer_id]) REFERENCES [dbo].[tblVaccineManufacturers] ([manufacturer_id])

GO
ALTER TABLE [dbo].[tblVaccineVISToURL] WITH CHECK ADD CONSTRAINT [FK_tblVaccineVISToURL_tblVaccineVIS]
   FOREIGN KEY([vis_concept_id]) REFERENCES [dbo].[tblVaccineVIS] ([vis_concept_id])

GO
