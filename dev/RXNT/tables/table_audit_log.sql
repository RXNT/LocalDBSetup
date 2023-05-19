CREATE TABLE [dbo].[table_audit_log] (
   [audit_id] [uniqueidentifier] NOT NULL,
   [table_name] [varchar](100) NOT NULL,
   [dg_id] [int] NOT NULL,
   [src_id] [int] NOT NULL,
   [src_name] [varchar](50) NOT NULL,
   [target_id] [int] NOT NULL,
   [target_name] [varchar](50) NOT NULL,
   [evt_date] [smalldatetime] NOT NULL,
   [sql_login] [varchar](50) NOT NULL,
   [columns_updated] [xml] NULL

   ,CONSTRAINT [PK_table_audit_log] PRIMARY KEY CLUSTERED ([audit_id])
)


GO
