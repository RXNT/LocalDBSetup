ALTER TABLE [phr].[PatientPortalDocuments] WITH CHECK ADD CONSTRAINT [FK_PatientPortalDocuments_patient_documents]
   FOREIGN KEY([DocumentId]) REFERENCES [dbo].[patient_documents] ([document_id])

GO
ALTER TABLE [phr].[PatientPortalDocuments] WITH CHECK ADD CONSTRAINT [FK_PatientPortalDocuments_PatientRepresentatives]
   FOREIGN KEY([PatientRepresentativeId]) REFERENCES [phr].[PatientRepresentatives] ([PatientRepresentativeId])

GO
