ALTER TABLE [dbo].[tblPatientExternalVaccinationRequestDetails] WITH CHECK ADD CONSTRAINT [FK__tblPatien__reque__3EA44E34]
   FOREIGN KEY([request_id]) REFERENCES [dbo].[tblPatientExternalVaccinationRequests] ([request_id])

GO
