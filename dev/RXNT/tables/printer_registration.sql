CREATE TABLE [dbo].[printer_registration] (
   [print_reg_id] [int] NOT NULL
      IDENTITY (1,1),
   [printer_title] [varchar](255) NOT NULL,
   [printer_desc] [varchar](255) NOT NULL,
   [add_date] [datetime] NOT NULL,
   [pm_id] [int] NOT NULL

   ,CONSTRAINT [PK_printer_registration] PRIMARY KEY CLUSTERED ([print_reg_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN_1] ON [dbo].[printer_registration] ([printer_title], [printer_desc], [pm_id])

GO
