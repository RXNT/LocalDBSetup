CREATE TABLE [dbo].[coverage_reference] (
   [cr_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [plan_numb] [varchar](15) NULL,
   [plan_name] [varchar](35) NOT NULL,
   [grp_numb] [varchar](15) NULL,
   [grp_name] [varchar](35) NULL,
   [cov_list_id] [varchar](50) NOT NULL,
   [cov_list_type] [varchar](2) NOT NULL

   ,CONSTRAINT [PK_coverage_reference] PRIMARY KEY CLUSTERED ([cr_id])
)


GO
