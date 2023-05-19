CREATE TABLE [dbo].[tblPatientExternalVaccinationRequests] (
   [request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [patient_id] [bigint] NOT NULL,
   [message_control_id] [varchar](100) NOT NULL,
   [dr_id] [bigint] NOT NULL,
   [request_file_path] [varchar](1000) NULL,
   [response_file_path] [varchar](1000) NULL,
   [requested_date] [datetime] NULL,
   [response_received_date] [datetime] NULL,
   [status] [varchar](100) NULL,
   [comments] [varchar](max) NULL

   ,CONSTRAINT [PK__tblPatie__18D3B90F0D0E0C90] PRIMARY KEY CLUSTERED ([request_id])
   ,CONSTRAINT [UQ__tblPatie__D665D431C8755ABE] UNIQUE NONCLUSTERED ([message_control_id])
)


GO
