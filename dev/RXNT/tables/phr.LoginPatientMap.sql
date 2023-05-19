CREATE TABLE [phr].[LoginPatientMap] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [LoginId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [Type] [tinyint] NOT NULL,
   [CreatedBy] [int] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [ModifiedBy] [int] NULL,
   [ModifiedDate] [datetime2] NULL,
   [InactivatedBy] [int] NULL,
   [InactivatedDate] [datetime2] NULL

   ,CONSTRAINT [PK_LoginPatientMap] PRIMARY KEY NONCLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [IX_LoginPatientMap_LoginIdPatientId] ON [phr].[LoginPatientMap] ([LoginId], [PatientId])

GO
