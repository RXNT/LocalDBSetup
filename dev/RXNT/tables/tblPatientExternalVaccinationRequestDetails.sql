CREATE TABLE [dbo].[tblPatientExternalVaccinationRequestDetails] (
   [request_details_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [message_control_id] [varchar](100) NOT NULL,
   [request_id] [bigint] NOT NULL,
   [outgoing_message] [varchar](max) NULL,
   [incoming_message] [varchar](max) NULL

   ,CONSTRAINT [UQ__tblPatie__18D3B90ED7938B43] UNIQUE NONCLUSTERED ([request_id])
)


GO
