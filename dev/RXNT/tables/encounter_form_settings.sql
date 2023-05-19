CREATE TABLE [dbo].[encounter_form_settings] (
   [enc_type_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [type] [varchar](125) NOT NULL,
   [date_added] [smalldatetime] NOT NULL,
   [name] [varchar](125) NOT NULL,
   [sort_order] [int] NULL

   ,CONSTRAINT [PK_encounter_form_settings] PRIMARY KEY CLUSTERED ([enc_type_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_UNIQUE] ON [dbo].[encounter_form_settings] ([dr_id], [type])

GO
