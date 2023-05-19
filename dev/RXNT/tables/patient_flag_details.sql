CREATE TABLE [dbo].[patient_flag_details] (
   [pa_flag_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [flag_id] [int] NOT NULL,
   [flag_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_flag_details] PRIMARY KEY CLUSTERED ([pa_flag_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_flag_details-pa_id-flag_id] ON [dbo].[patient_flag_details] ([pa_id], [flag_id])

GO
