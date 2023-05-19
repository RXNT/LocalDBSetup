CREATE TABLE [dbo].[doc_reports_log] (
   [dr_report_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [print_date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_doc_reports_log] PRIMARY KEY CLUSTERED ([dr_report_id])
)


GO
