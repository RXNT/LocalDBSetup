CREATE TABLE [dbo].[Patient_merge_transaction] (
   [pa_merge_transaction_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_merge_reqid] [bigint] NOT NULL,
   [status] [varchar](20) NULL,
   [created_date] [datetime] NULL,
   [last_modified] [datetime] NULL

   ,CONSTRAINT [PK_Patient_merge_transaction] PRIMARY KEY CLUSTERED ([pa_merge_transaction_id])
)


GO
