CREATE TABLE [phr].[RegistrationWorkflow] (
   [Id] [uniqueidentifier] NOT NULL,
   [RegistrationWorkflowStateId] [int] NOT NULL,
   [Otp] [varchar](6) NOT NULL,
   [OtpExpiryDate] [datetime2] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [DoctorGroupId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [Nonce] [uniqueidentifier] NULL

   ,CONSTRAINT [PK_RegistrationWorkflow] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
