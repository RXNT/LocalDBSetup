CREATE TABLE [dbo].[doctor_printserver_reg] (
   [dr_id] [int] NOT NULL,
   [master_id] [int] NOT NULL,
   [reg_id_rx] [int] NOT NULL,
   [reg_id_plain] [int] NOT NULL,
   [print_server] [bit] NOT NULL

   ,CONSTRAINT [PK_doctor_printserver_reg] PRIMARY KEY NONCLUSTERED ([dr_id], [master_id])
)

CREATE UNIQUE CLUSTERED INDEX [IX_MAIN] ON [dbo].[doctor_printserver_reg] ([dr_id])

GO
