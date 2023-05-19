CREATE TABLE [fdb_a].[active_drugs] (
   [medid] [int] NOT NULL,
   [is_active] [bit] NOT NULL

   ,CONSTRAINT [PK_active_drugs] PRIMARY KEY CLUSTERED ([medid])
)

CREATE NONCLUSTERED INDEX [IX_active_drugs] ON [fdb_a].[active_drugs] ([medid], [is_active])

GO
