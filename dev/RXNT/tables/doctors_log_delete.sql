CREATE TABLE [dbo].[doctors_log_delete] (
   [dr_log_del_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [dg_id] [int] NULL,
   [dr_field_not_used1] [int] NULL,
   [dr_prefix] [varchar](10) NULL,
   [dr_first_name] [varchar](50) NULL,
   [dr_middle_initial] [varchar](2) NULL,
   [dr_last_name] [varchar](50) NULL,
   [deleting_user] [varchar](100) NULL

   ,CONSTRAINT [PK_doctors_log_delete] PRIMARY KEY CLUSTERED ([dr_log_del_id])
)


GO
