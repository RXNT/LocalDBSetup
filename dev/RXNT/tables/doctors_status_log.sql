CREATE TABLE [dbo].[doctors_status_log] (
   [ds_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [change_date] [datetime] NULL,
   [changer_id] [varchar](50) NULL

   ,CONSTRAINT [PK_doctors_status_log] PRIMARY KEY CLUSTERED ([ds_log_id])
)


GO
