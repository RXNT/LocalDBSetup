CREATE TABLE [dbo].[tblHealthGuidelinesTemplates] (
   [template_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [template_name] [varchar](100) NULL,
   [template_path] [varchar](255) NULL,
   [template_type] [tinyint] NULL,
   [isactive] [bit] NULL,
   [added_by_dr_id] [bigint] NULL,
   [date_added] [smalldatetime] NULL

   ,CONSTRAINT [PK_tblHealthGuidelinesTemplates] PRIMARY KEY CLUSTERED ([template_id])
)


GO
