CREATE TABLE [dbo].[CQM_Measure_Reports] (
   [cqm_repid] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [bigint] NULL,
   [start_date] [datetime] NULL,
   [end_date] [datetime] NULL,
   [cqm_text] [varchar](max) NULL,
   [executed_date] [datetime] NULL,
   [report_version] [varchar](5) NULL

   ,CONSTRAINT [PK__CQM_Meas__3F72938A2BC1BFE0] PRIMARY KEY CLUSTERED ([cqm_repid])
)


GO
