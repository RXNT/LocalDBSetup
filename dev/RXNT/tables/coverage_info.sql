CREATE TABLE [dbo].[coverage_info] (
   [ci_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [cov_list_id] [varchar](50) NOT NULL,
   [cov_list_type] [varchar](2) NOT NULL,
   [ndc] [varchar](11) NOT NULL,
   [description] [varchar](50) NULL

   ,CONSTRAINT [PK_coverage_info] PRIMARY KEY CLUSTERED ([ci_id])
)


GO
