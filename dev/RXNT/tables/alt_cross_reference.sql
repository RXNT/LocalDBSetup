CREATE TABLE [dbo].[alt_cross_reference] (
   [acr_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [alternative_id] [varchar](10) NOT NULL,
   [rel_value_limit] [int] NOT NULL

   ,CONSTRAINT [PK_alt_cross_reference] PRIMARY KEY CLUSTERED ([acr_id])
)


GO
