CREATE TABLE [dbo].[form_reference] (
   [ref_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [plan_numb] [varchar](15) NULL,
   [plan_name] [varchar](35) NOT NULL,
   [grp_numb] [varchar](15) NULL,
   [grp_name] [varchar](35) NULL,
   [formulary_id] [varchar](10) NOT NULL,
   [alternative_id] [varchar](10) NULL

   ,CONSTRAINT [PK_form_reference] PRIMARY KEY CLUSTERED ([ref_id])
)


GO
