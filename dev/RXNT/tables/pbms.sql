CREATE TABLE [dbo].[pbms] (
   [pbm_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [pbm_name] [varchar](50) NOT NULL,
   [pbm_notes] [varchar](255) NOT NULL,
   [disp_string] [varchar](255) NOT NULL,
   [disp_options] [varchar](255) NOT NULL,
   [is_gcn_based_form] [bit] NULL

   ,CONSTRAINT [PK_pbms] PRIMARY KEY CLUSTERED ([pbm_id])
)


GO
