CREATE TABLE [dbo].[doc_group_fav_scripts] (
   [script_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [ddid] [int] NOT NULL,
   [dosage] [varchar](255) NOT NULL,
   [use_generic] [bit] NOT NULL,
   [numb_refills] [int] NULL,
   [duration_unit] [varchar](80) NULL,
   [duration_amount] [varchar](10) NULL,
   [comments] [varchar](255) NOT NULL,
   [prn] [bit] NOT NULL,
   [as_directed] [bit] NOT NULL,
   [update_code] [int] NULL,
   [drug_version] [varchar](10) NOT NULL,
   [prn_description] [varchar](50) NOT NULL,
   [compound] [bit] NOT NULL,
   [days_supply] [smallint] NULL,
   [hospice_drug_relatedness_id] [int] NULL,
   [drug_indication] [varchar](50) NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_scripts] PRIMARY KEY NONCLUSTERED ([script_id])
)


GO
