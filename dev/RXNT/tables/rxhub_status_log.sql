CREATE TABLE [dbo].[rxhub_status_log] (
   [rsl_id] [int] NOT NULL
      IDENTITY (1,1),
   [ctrl_ref_num] [varchar](50) NOT NULL,
   [trc_num] [varchar](50) NOT NULL,
   [status_code] [varchar](10) NOT NULL,
   [status_msg] [varchar](255) NULL,
   [status_code_qualifier] [varchar](10) NULL,
   [recved_date] [datetime] NOT NULL,
   [init_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_rxhub_status_log] PRIMARY KEY CLUSTERED ([rsl_id])
)


GO
