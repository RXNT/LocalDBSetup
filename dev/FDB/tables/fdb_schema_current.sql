CREATE TABLE [dbo].[fdb_schema_current] (
   [fdb_schema_current_id] [int] NOT NULL,
   [fdb_schema_current_name] [varchar](10) NOT NULL,
   [fdb_schema_current_activated] [datetime] NOT NULL,
   [fdb_schema_next_name] [varchar](10) NOT NULL,
   [fdb_schema_next_has_errors] [bit] NOT NULL,
   [fdb_schema_next_need_index_rebuild] [bit] NOT NULL

   ,CONSTRAINT [PK_fdb_schema_current] PRIMARY KEY CLUSTERED ([fdb_schema_current_id])
)


GO
