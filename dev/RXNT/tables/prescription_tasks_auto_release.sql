CREATE TABLE [dbo].[prescription_tasks_auto_release] (
   [pd_id] [bigint] NOT NULL,
   [pres_id] [bigint] NULL,
   [performed_on] [datetime] NULL,
   [api_response_success] [bit] NULL

   ,CONSTRAINT [PK_prescription_tasks_auto_release] PRIMARY KEY CLUSTERED ([pd_id])
)


GO
