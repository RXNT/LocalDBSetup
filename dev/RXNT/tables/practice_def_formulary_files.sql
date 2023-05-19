CREATE TABLE [dbo].[practice_def_formulary_files] (
   [def_tab_id] [int] NOT NULL
      IDENTITY (1,1),
   [form_table_name] [varchar](500) NULL,
   [copay_table_name] [varchar](500) NULL,
   [coverage_table_name] [varchar](500) NULL,
   [dc_id] [int] NOT NULL,
   [pbms_cross_id] [varchar](30) NOT NULL,
   [PBM_NAME] [varchar](30) NULL

   ,CONSTRAINT [PK_practice_def_formulary_files] PRIMARY KEY CLUSTERED ([def_tab_id])
)


GO
