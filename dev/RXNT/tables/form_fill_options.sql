CREATE TABLE [dbo].[form_fill_options] (
   [dg_id] [int] NOT NULL,
   [type] [smallint] NOT NULL,
   [value] [varchar](512) NOT NULL,
   [sort_order] [int] NOT NULL,
   [form_fill_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_form_fill_options] PRIMARY KEY CLUSTERED ([form_fill_id])
)

CREATE NONCLUSTERED INDEX [IX_form_fill_options] ON [dbo].[form_fill_options] ([dg_id], [type])

GO
