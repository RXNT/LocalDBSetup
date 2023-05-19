CREATE TABLE [dbo].[PrinterMaster] (
   [pm_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NULL,
   [LocationName] [varchar](255) NULL,
   [last_updated_date] [datetime] NULL,
   [is_activated] [bit] NOT NULL

   ,CONSTRAINT [PK_PrinterMaster] PRIMARY KEY CLUSTERED ([pm_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN_1] ON [dbo].[PrinterMaster] ([dc_id], [is_activated])

GO
