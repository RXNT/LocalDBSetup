CREATE TABLE [dbo].[doc_group_freetext_med_ingredients] (
   [dgfmi_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dgfm_id] [int] NOT NULL,
   [ingredient_drug_id] [int] NULL,
   [drug_id] [int] NOT NULL,
   [drug_level] [int] NOT NULL,
   [comp_ingredient] [varchar](200) NOT NULL,
   [strength_value] [varchar](10) NULL,
   [strength_unit_id] [int] NULL,
   [strength_form_id] [int] NULL,
   [qty] [varchar](50) NOT NULL,
   [qty_unit_id] [int] NOT NULL,
   [is_active] [bit] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [last_modified_date] [datetime] NULL
)


GO
