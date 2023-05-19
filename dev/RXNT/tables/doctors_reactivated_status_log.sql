CREATE TABLE [dbo].[doctors_reactivated_status_log] (
   [rds_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [reactivated_date] [datetime] NULL,
   [reactivated_id] [varchar](50) NULL

   ,CONSTRAINT [PK_doctors_reactivated_status_log] PRIMARY KEY CLUSTERED ([rds_log_id])
)


GO
