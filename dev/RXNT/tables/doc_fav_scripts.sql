CREATE TABLE [dbo].[doc_fav_scripts] (
   [script_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
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
   [drug_indication] [varchar](100) NULL

   ,CONSTRAINT [PK_doc_fav_scripts] PRIMARY KEY NONCLUSTERED ([script_id])
)

CREATE NONCLUSTERED INDEX [_doc_fav_script2] ON [dbo].[doc_fav_scripts] ([dr_id], [ddid])
CREATE CLUSTERED INDEX [_doc_fav_scripts] ON [dbo].[doc_fav_scripts] ([script_id])

GO
