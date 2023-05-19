CREATE TABLE [dbo].[page_exec_log] (
   [pg_exec_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [page_name] [varchar](125) NULL,
   [dg_id] [int] NULL,
   [exec_time] [int] NULL,
   [date_log] [smalldatetime] NULL

   ,CONSTRAINT [PK_page_exec_log] PRIMARY KEY CLUSTERED ([pg_exec_log_id])
)


GO
