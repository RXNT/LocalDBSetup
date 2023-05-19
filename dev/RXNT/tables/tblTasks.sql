CREATE TABLE [dbo].[tblTasks] (
   [task_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [task_name] [nvarchar](100) NOT NULL,
   [task_src] [int] NOT NULL,
   [task_dst] [int] NOT NULL,
   [date_created] [datetime] NOT NULL,
   [end_date] [datetime] NOT NULL,
   [priority] [tinyint] NOT NULL,
   [status] [tinyint] NOT NULL,
   [task_details] [ntext] NULL,
   [task_src_deleted] [bit] NULL,
   [task_dst_deleted] [bit] NULL

   ,CONSTRAINT [PK__tblTasks__29221CFB] PRIMARY KEY CLUSTERED ([task_id])
)

CREATE NONCLUSTERED INDEX [IX_tblTasks] ON [dbo].[tblTasks] ([end_date], [task_src], [task_dst], [priority], [status])

GO
