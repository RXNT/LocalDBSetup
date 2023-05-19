CREATE TABLE [dbo].[form_cross_reference] (
   [fcr_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [formulary_id] [varchar](10) NOT NULL,
   [formulary_name] [varchar](35) NULL,
   [otc_default] [int] NULL,
   [generic_default] [int] NULL,
   [nonlist_brand] [int] NULL,
   [nonlist_generic] [int] NULL,
   [rel_value_limit] [int] NOT NULL

   ,CONSTRAINT [PK_form_cross_reference] PRIMARY KEY CLUSTERED ([fcr_id])
)


GO
