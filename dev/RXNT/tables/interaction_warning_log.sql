CREATE TABLE [dbo].[interaction_warning_log] (
   [int_warn_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [response] [tinyint] NOT NULL,
   [date] [smalldatetime] NOT NULL,
   [warning_source] [smallint] NULL,
   [reason] [varchar](255) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_interaction_warning_log] PRIMARY KEY CLUSTERED ([int_warn_id])
)

CREATE NONCLUSTERED INDEX [IDX_interaction_warning_log_pa_id] ON [dbo].[interaction_warning_log] ([pa_id])

GO
