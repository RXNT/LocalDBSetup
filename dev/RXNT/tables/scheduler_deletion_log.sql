CREATE TABLE [dbo].[scheduler_deletion_log] (
   [sch_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [deletion_date] [datetime] NULL,
   [reason] [varchar](1000) NULL,
   [event_id] [int] NULL

   ,CONSTRAINT [PK__schedule__DFC97B7769B40561] PRIMARY KEY CLUSTERED ([sch_log_id])
)


GO
