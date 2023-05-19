CREATE TABLE [dbo].[patient_procedures] (
   [procedure_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [date_performed] [smalldatetime] NULL,
   [type] [varchar](50) NULL,
   [status] [varchar](50) NULL,
   [code] [varchar](50) NULL,
   [description] [varchar](250) NULL,
   [notes] [varchar](255) NULL,
   [record_modified_date] [datetime] NULL,
   [date_performed_to] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [reason_type] [varchar](50) NULL,
   [reason] [varchar](50) NULL,
   [reason_type_code] [varchar](50) NULL,
   [no_of_units] [int] NULL,
   [modifier] [varchar](30) NULL,
   [modifier_name] [varchar](255) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_procedures] PRIMARY KEY CLUSTERED ([procedure_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_procedures] ON [dbo].[patient_procedures] ([pa_id], [dr_id], [date_performed] DESC)

GO
