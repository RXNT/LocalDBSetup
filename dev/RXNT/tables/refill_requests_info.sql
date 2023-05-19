CREATE TABLE [dbo].[refill_requests_info] (
   [refreqinfo_id] [int] NOT NULL
      IDENTITY (1,1),
   [refreq_id] [int] NOT NULL,
   [type] [varchar](7) NOT NULL,
   [drug_name] [varchar](125) NULL,
   [drug_ndc] [varchar](11) NULL,
   [drug_form] [varchar](3) NULL,
   [drug_strength] [varchar](70) NULL,
   [drug_strength_units] [varchar](3) NULL,
   [qty1] [varchar](35) NULL,
   [qty1_units] [varchar](50) NULL,
   [qty1_enum] [tinyint] NULL,
   [qty2] [varchar](35) NULL,
   [qty2_units] [varchar](50) NULL,
   [qty2_enum] [tinyint] NULL,
   [dosage1] [varchar](140) NULL,
   [dosage2] [varchar](70) NULL,
   [days_supply] [int] NULL,
   [date1] [smalldatetime] NULL,
   [date1_enum] [tinyint] NULL,
   [date2] [smalldatetime] NULL,
   [date2_enum] [tinyint] NULL,
   [date3] [smalldatetime] NULL,
   [date3_enum] [tinyint] NULL,
   [substitution_code] [tinyint] NULL,
   [refills] [varchar](35) NULL,
   [refills_enum] [tinyint] NULL,
   [void_comments] [varchar](255) NULL,
   [void_code] [smallint] NULL,
   [comments1] [varchar](210) NULL,
   [comments2] [varchar](70) NULL,
   [comments3] [varchar](70) NULL,
   [drug_strength_code] [varchar](15) NULL,
   [drug_strength_source_code] [varchar](3) NULL,
   [drug_form_code] [varchar](15) NULL,
   [drug_form_source_code] [varchar](3) NULL,
   [qty1_units_potency_code] [varchar](15) NULL,
   [qty2_units_potency_code] [varchar](15) NULL,
   [doc_info_text] [varchar](5000) NULL

   ,CONSTRAINT [PK_refill_requests_info] PRIMARY KEY NONCLUSTERED ([refreqinfo_id])
)

CREATE NONCLUSTERED INDEX [index_refill_requests_info1] ON [dbo].[refill_requests_info] ([refreq_id]) INCLUDE ([drug_name], [qty1], [qty1_units], [dosage1], [dosage2], [days_supply], [date1], [date1_enum], [date2], [date2_enum], [date3], [date3_enum], [refills], [comments1], [comments2], [comments3])
CREATE UNIQUE CLUSTERED INDEX [PK_RefInfo] ON [dbo].[refill_requests_info] ([refreqinfo_id], [refreq_id])

GO
